#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2019
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

set -o nounset
set -o pipefail
set -o errexit
set -o xtrace

# Discovery process

# Management network - Used for internal communication between OpenStack Components. The IP addresses on this network should be reachable only within the data center and is considered the Management Security Domain.
mgmt_nic=$(ip route | grep "^192" | head -n1 | awk '{ print $3 }')
mgmt_ip=$(ip addr | awk "/${mgmt_nic}\$/ { sub(/\/[0-9]*/, \"\","' $2); print $2}')

# Guest network - Used for VM data communication within the cloud deployment. The IP addressing requirements of this network depend on the OpenStack Networking plug-in in use and the network configuration choices of the virtual networks made by the tenant. This network is considered the Guest Security Domain.

# External network - Used to provide VMs with Internet access in some deployment scenarios. The IP addresses on this network should be reachable by anyone on the Internet. This network is considered to be in the Public Security Domain.
# API network - Exposes all OpenStack APIs, including the OpenStack Networking API, to tenants. The IP addresses on this network should be reachable by anyone on the Internet. This may be the same network as the external network, as it is possible to create a subnet for the external network that uses IP allocation ranges to use only less than the full range of IP addresses in an IP block. This network is considered the Public Security Domain.
public_nic=$(ip route | grep "^10" | head -n1 | awk '{ print $3 }')
if [ -z "$public_nic" ]; then
    public_nic=${mgmt_nic}
fi
public_ip=$(ip addr | awk "/${public_nic}\$/ { sub(/\/[0-9]*/, \"\","' $2); print $2}')

export DOCKER_REGISTRY_PORT=${DOCKER_REGISTRY_PORT:-6000}
export OPENSTACK_RELEASE=${OPENSTACK_RELEASE:-stein}
OS_FOLDER=${OS_FOLDER:-/opt/openstack-multinode}
OS_FLAVOR=${OS_FLAVOR:-aio}
export OS_KOLLA_USER=${OS_KOLLA_USER:-root}
kolla_internal_vip_address=${OS_KOLLA_INTERNAL_VIP_ADDRESS:-$mgmt_ip}
kolla_external_vip_address=${OS_KOLLA_EXTERNAL_VIP_ADDRESS:-$mgmt_ip}
enable_haproxy="yes"
if [ "${kolla_external_vip_address}" == "${mgmt_ip}" ]; then
    enable_haproxy="no"
fi

# Validation process

if ! sudo -n "true"; then
    echo ""
    echo "passwordless sudo is needed for '$(id -nu)' user."
    echo "Please fix your /etc/sudoers file. You likely want an"
    echo "entry like the following one..."
    echo ""
    echo "$(id -nu) ALL=(ALL) NOPASSWD: ALL"
    exit 1
fi

# Validating local IP addresses in no_proxy environment variable
if [[ ${NO_PROXY+x} = "x" ]]; then
    for ip in $(hostname --ip-address || hostname -i) ${mgmt_ip} ${public_ip}; do
        if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$  &&  $NO_PROXY != *"$ip"* ]]; then
            echo "The $ip IP address is not defined in NO_PROXY env"
            exit 1
        fi
    done
fi

# shellcheck disable=SC1091
source /etc/os-release || source /usr/lib/os-release
case ${ID,,} in
    *suse)
    INSTALLER_CMD="sudo -H -E zypper -q install -y --no-recommends"
    sudo zypper -n ref
    ;;

    ubuntu|debian)
    INSTALLER_CMD="sudo -H -E apt-get -y -q=3 install"
    sudo apt-get update
    ;;

    rhel|centos|fedora)
    PKG_MANAGER=$(command -v dnf || command -v yum)
    INSTALLER_CMD="sudo -H -E ${PKG_MANAGER} -q -y install"
    sudo "$PKG_MANAGER" updateinfo
    ;;
esac

if ! command -v wget; then
    ${INSTALLER_CMD} wget
fi
echo "Sync server's clock"
sudo date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f5-8)Z"

if ! command -v git; then
    ${INSTALLER_CMD} git
fi
echo "Cloning and configuring openstack-multinode project..."
if [ ! -d "${OS_FOLDER}" ]; then
    sudo -E git clone --depth 1 https://github.com/electrocucaracha/openstack-multinode "${OS_FOLDER:-/opt/openstack-multinode}"
    sudo chown -R "$USER" "${OS_FOLDER}"
fi
cd "${OS_FOLDER}" || exit

sudo mkdir -p /etc/kolla/config
sudo cp etc/kolla/kolla-build.ini /etc/kolla/kolla-build.ini
sudo sed -i "s/^registry = .*/registry = ${mgmt_ip}:${DOCKER_REGISTRY_PORT}/g" /etc/kolla/kolla-build.ini
./registry.sh

# OpenStack Deployment process

sudo cp -R etc/kolla-ansible/* /etc/kolla/
# NOTE: Required for resolving rabbitmq hostname
echo "127.0.0.1       localhost      $(hostname)" | sudo tee /etc/hosts
sudo sed -i "s/^docker_registry: .*/docker_registry: ${mgmt_ip}:${DOCKER_REGISTRY_PORT}/g" /etc/kolla/globals.yml

# These endpoints are the admin URL, the internal URL, and the external URL.
sudo sed -i "s/^kolla_internal_vip_address: .*/kolla_internal_vip_address: ${kolla_internal_vip_address}/g" /etc/kolla/globals.yml
sudo sed -i "s/^kolla_external_vip_address: .*/kolla_external_vip_address: ${kolla_external_vip_address}/g" /etc/kolla/globals.yml
sudo sed -i "s/^enable_haproxy: .*/enable_haproxy: ${enable_haproxy}/g" /etc/kolla/globals.yml

# While it is not used on its own, this provides the required default for other interfaces below.
sudo sed -i "s/^network_interface: .*/network_interface: \"${mgmt_nic}\"/g" /etc/kolla/globals.yml
# This interface is used for the management network. The management network is the network OpenStack services uses to communicate to each other and the databases.
sudo sed -i "s/^api_interface: .*/api_interface: \"${mgmt_nic}\"/g" /etc/kolla/globals.yml
# This interface is public-facing one. It’s used when you want HAProxy public endpoints to be exposed in different network than internal ones.
sudo sed -i "s/^kolla_external_vip_interface: .*/kolla_external_vip_interface: \"${public_nic}\"/g" /etc/kolla/globals.yml
# This interface is used by Neutron for vm-to-vm traffic over tunneled networks (like VxLan).
sudo sed -i "s/^tunnel_interface: .*/tunnel_interface: \"${mgmt_nic}\"/g" /etc/kolla/globals.yml
# This interface is required by Neutron. Neutron will put br-ex on it. It will be used for flat networking as well as tagged vlan networks. Has to be set separately.
sudo sed -i "s/^neutron_external_interface: .*/neutron_external_interface: \"${public_nic}\"/g" /etc/kolla/globals.yml

sudo sed -i "s/^openstack_release: .*/openstack_release: \"${OPENSTACK_RELEASE}\"/g" /etc/kolla/globals.yml
OS_INVENTORY_FILE="./samples/${OS_FLAVOR}/hosts.ini" ./undercloud.sh

# Post-Install actions

# shellcheck disable=SC1091
source /etc/kolla/admin-openrc.sh
case ${ID,,} in
    ubuntu|debian)
    /usr/local/share/kolla-ansible/init-runonce
    ;;
    rhel|centos|fedora)
    /usr/share/kolla-ansible/init-runonce
    ;;
esac
openstack flavor set m1.large --property pci_passthrough:alias=C62x:1
