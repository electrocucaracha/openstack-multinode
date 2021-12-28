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
if [[ "${OS_DEBUG:-false}" == "true" ]]; then
    export PKG_DEBUG=true
    set -o xtrace
fi

#####################
# Discovery process #
#####################

# Management network - Used for internal communication between
# OpenStack Components. The IP addresses on this network should be
# reachable only within the data center and is considered the
# Management Security Domain.
mgmt_nic=$(ip route get 8.8.8.8 | grep "^8." | awk '{ print $5 }')
mgmt_ip=$(ip route get 8.8.8.8 | grep "^8." | awk '{ print $7 }')

# Guest network - Used for VM data communication within the cloud
# deployment. The IP addressing requirements of this network depend
# on the OpenStack Networking plug-in in use and the network
# configuration choices of the virtual networks made by the tenant.
# This network is considered the Guest Security Domain.

# External network - Used to provide VMs with Internet access in some
# deployment scenarios. The IP addresses on this network should be
# reachable by anyone on the Internet. This network is considered to
# be in the Public Security Domain.

# API network - Exposes all OpenStack APIs, including the OpenStack
# Networking API, to tenants. The IP addresses on this network should
# be reachable by anyone on the Internet. This may be the same network
# as the external network, as it is possible to create a subnet for
# the external network that uses IP allocation ranges to use only less
# than the full range of IP addresses in an IP block. This network is
# considered the Public Security Domain.
if ip route | grep -q "^10.10"; then
    public_nic=$(ip route | grep "^10.10" | awk '{ print $3 }')
else
    if [ -z "${OS_KOLLA_NEUTRON_EXTERNAL_INTERFACE:-}" ]; then
        echo "ERROR: Using the management network interface as Neutron External can result in losing external connectivity"
        exit 1
    fi
    public_nic=${mgmt_nic}
fi
public_ip=$(ip addr | awk "/${public_nic}\$/ { sub(/\/[0-9]*/, \"\","' $2); print $2}')

export DOCKER_REGISTRY_PORT=${DOCKER_REGISTRY_PORT:-6000}
OS_FOLDER=${OS_FOLDER:-/opt/openstack-multinode}
export OS_KOLLA_INTERNAL_VIP_ADDRESS=${OS_KOLLA_INTERNAL_VIP_ADDRESS:-$mgmt_ip}
export OS_KOLLA_NETWORK_INTERFACE=$mgmt_nic
if [ -z "${OS_KOLLA_NEUTRON_EXTERNAL_INTERFACE:-}" ]; then
    export OS_KOLLA_NEUTRON_EXTERNAL_INTERFACE=$public_nic
fi

######################
# Validation process #
######################

# Validating passwordless sudo
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
if [ -n "${NO_PROXY:-}" ]; then
    for ip in $(hostname --ip-address || hostname -i) ${mgmt_ip} ${public_ip}; do
        if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$  &&  $NO_PROXY != *"$ip"* ]]; then
            echo "The $ip IP address is not defined in NO_PROXY env"
            exit 1
        fi
    done
fi

# Validating SELinux
if command -v sestatus && [[ $(sestatus | grep Current) != *permissive* ]]; then
    echo ""
    echo "SELinux requires to be configured as Permissive mode."
    echo "Please fix your /etc/selinux/config file."
    exit 1
fi

# Ensuring project's source code
if [ ! -d "${OS_FOLDER}" ]; then
    # NOTE: Shorten link -> https://github.com/electrocucaracha/pkg-mgr_scripts
    curl -fsSL http://bit.ly/install_pkg | PKG_COMMANDS_LIST="git" bash

    echo "Cloning and configuring openstack-multinode project..."
    sudo -E git clone --depth 1 https://github.com/electrocucaracha/openstack-multinode "${OS_FOLDER:-/opt/openstack-multinode}"
    sudo chown -R "$USER" "${OS_FOLDER}"
fi
cd "${OS_FOLDER}" || exit
sudo mkdir -p /etc/kolla/config
sudo cp -R etc/kolla/* /etc/kolla/
sudo chown "$USER" /etc/kolla/passwords.yml

for os_var in $(printenv | grep OS_); do
    echo "export $os_var" | sudo tee --append /etc/environment
done

###############################
# OpenStack Registry creation #
###############################

if [ "${OS_ENABLE_LOCAL_REGISTRY:-false}" == "true" ]; then
    export DOCKER_REGISTRY_IP=${mgmt_ip}
    export DOCKER_REGISTRY_PORT=${DOCKER_REGISTRY_PORT}
    ./registry.sh
fi

################################
# OpenStack Deployment process #
################################

./undercloud.sh

# Post-Install actions
if [ "${OS_KOLLA_RUN_INIT:-true}" == "true" ]; then
    # PEP 370 -- Per user site-packages directory
    [[ "$PATH" != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin

    sudo chown "$USER:" /etc/kolla/admin-openrc.sh
    # shellcheck disable=SC1091
    source /etc/kolla/admin-openrc.sh
    if [ ! -f /tmp/init-runonce ]; then
        curl -sL -o /tmp/init-runonce https://raw.githubusercontent.com/openstack/kolla-ansible/master/tools/init-runonce
        chmod +x /tmp/init-runonce
    fi
    /tmp/init-runonce

    if [ "${OS_KOLLA_ENABLE_MAGNUM:-no}" == "yes" ]; then
        ./scripts/magnum.sh
    fi
    if [ "${OS_KOLLA_ENABLE_NEUTRON_TRUNK:-yes}" == "yes" ]; then
        ./scripts/neutron_trunk.sh
    fi
fi
