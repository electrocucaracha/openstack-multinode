#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2018
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

# Variables
kolla_folder=/opt/kolla-ansible
kolla_version=${OS_KOLLA_ANSIBLE_VERSION:-10.1.0}

pkgs="python-devel pip sshpass"
if ! command -v gcc; then
    pkgs+=" gcc"
fi
curl -fsSL http://bit.ly/install_pkg | PKG=$pkgs PKG_UPDATE=true bash

if [ ! -d ${kolla_folder} ]; then
    pushd "$(mktemp -d)"
    curl -o kolla-ansible.tar.gz "https://tarballs.opendev.org/openstack/kolla-ansible/kolla-ansible-${kolla_version}.tar.gz"
    tar -xzf kolla-ansible.tar.gz
    rm kolla-ansible.tar.gz
    sudo mv kolla-ansible-* "$kolla_folder"
    sed -i "s|pip3|$(command -v pip3)|g" "$kolla_folder/ansible/roles/baremetal/tasks/install.yml"
    # https://review.opendev.org/#/c/584427/17/ansible/roles/rabbitmq/templates/rabbitmq-env.conf.j2@6
    sed -i '/export ERL_EPMD_ADDRESS/d' "$kolla_folder/ansible/roles/rabbitmq/templates/rabbitmq-env.conf.j2"
    popd
fi

sudo touch /etc/timezone

pip install 'ansible<2.10'
pip install $kolla_folder
pip install python-openstackclient

sudo mkdir -p /etc/{kolla,ansible,systemd/system/docker.service.d}
if [ "${OS_ENABLE_LOCAL_REGISTRY:-false}" == "true" ]; then
    sudo sed -i "s/^#docker_registry: .*$/docker_registry: ${DOCKER_REGISTRY_IP:-127.0.0.1}:${DOCKER_REGISTRY_PORT:-5000}/g" /etc/kolla/globals.yml
fi
sudo sed -i "s/^#openstack_release: .*$/openstack_release: \"${OPENSTACK_RELEASE:-ussuri}\"/g"  /etc/kolla/globals.yml
sudo sed -i "s/^#kolla_base_distro: .*$/kolla_base_distro: \"${OS_KOLLA_BASE_DISTRO:-ubuntu}\"/g"  /etc/kolla/globals.yml
if [ -n "${HTTP_PROXY:-}" ]; then
    sed -i "s|^container_http_proxy: .*$|container_http_proxy: \"${HTTP_PROXY}\"|g" ~/.local/share/kolla-ansible/ansible/group_vars/all.yml
    echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf
    echo "Environment=\"HTTP_PROXY=$HTTP_PROXY\"" | sudo tee --append /etc/systemd/system/docker.service.d/http-proxy.conf
fi
if [ -n "${HTTPS_PROXY:-}" ]; then
    sed -i "s|^container_https_proxy: .*$|container_https_proxy: \"${HTTPS_PROXY}\"|g" ~/.local/share/kolla-ansible/ansible/group_vars/all.yml
    echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/https-proxy.conf
    echo "Environment=\"HTTPS_PROXY=$HTTPS_PROXY\"" | sudo tee --append /etc/systemd/system/docker.service.d/https-proxy.conf
fi
if [ -n "${NO_PROXY:-}" ]; then
    sed -i "s|^container_no_proxy: .*$|container_no_proxy: \"${NO_PROXY}\"|g" ~/.local/share/kolla-ansible/ansible/group_vars/all.yml
    echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/no-proxy.conf
    echo "Environment=\"NO_PROXY=$NO_PROXY\"" | sudo tee --append /etc/systemd/system/docker.service.d/no-proxy.conf
fi
sudo sed -i "s/^enable_cinder: .*/enable_cinder: \"${OS_KOLLA_ENABLE_CINDER:-yes}\"/g" /etc/kolla/globals.yml
sudo sed -i "s/^neutron_plugin_agent: .*/neutron_plugin_agent: \"${OS_KOLLA_NEUTRON_PLUGIN_AGENT:-openvswitch}\"/g" /etc/kolla/globals.yml
sudo sed -i "s/^#enable_magnum: .*/enable_magnum: \"${OS_KOLLA_ENABLE_MAGNUM:-no}\"/g" /etc/kolla/globals.yml
sudo sed -i "s/^#enable_haproxy: .*/enable_haproxy: \"${OS_KOLLA_ENABLE_HAPROXY:-no}\"/g" /etc/kolla/globals.yml
sudo sed -i "s/^#enable_skydive: .*/enable_skydive: \"${OS_KOLLA_ENABLE_SKYDIVE:-no}\"/g" /etc/kolla/globals.yml
# Kolla offers two options for assigning endpoints to network
# addresses
# - Combined: Where all three endpoints share the same IP address
# - Separate: Where the external URL is assigned to an IP address that
#             is different than the IP address shared by the internal
#             and admin URLs
sudo sed -i "s/^kolla_internal_vip_address: .*/kolla_internal_vip_address: ${OS_KOLLA_INTERNAL_VIP_ADDRESS}/g" /etc/kolla/globals.yml
if [ -n "${OS_KOLLA_EXTERNAL_VIP_ADDRESS:-}" ]; then
    sudo sed -i "s/^#kolla_external_vip_address: .*/kolla_external_vip_address: ${OS_KOLLA_EXTERNAL_VIP_ADDRESS}/g" /etc/kolla/globals.yml
fi
if [ -n "${OS_KOLLA_API_INTERFACE:-}" ]; then
    sudo sed -i "s/^#api_interface: .*/api_interface: ${OS_KOLLA_API_INTERFACE}/g" /etc/kolla/globals.yml
fi

sudo sed -i "s/^#network_interface: .*/network_interface: \"${OS_KOLLA_NETWORK_INTERFACE}\"/g" /etc/kolla/globals.yml
sudo sed -i "s/^#neutron_external_interface: .*/neutron_external_interface: \"${OS_KOLLA_NEUTRON_EXTERNAL_INTERFACE}\"/g" /etc/kolla/globals.yml

sudo tee /etc/ansible/ansible.cfg << EOL
[defaults]
host_key_checking=False
pipelinig=True
forks=100
remote_tmp=/tmp/
EOL

# PEP 370 -- Per user site-packages directory
[[ "$PATH" != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin

kolla-genpwd
sudo rm -f /etc/docker/daemon.json
kolla_actions=(bootstrap-servers prechecks pull deploy check post-deploy)
if [ "${OS_KOLLA_DEPLOY_PROFILE:-complete}" == "minimal" ]; then
    kolla_actions=(bootstrap-servers deploy post-deploy)
fi
for action in "${kolla_actions[@]}"; do
    ./run_kaction.sh "$action" | tee "$HOME/$action.log"
done

# shellcheck disable=SC2002
cat /etc/kolla/admin-openrc.sh | sudo tee --append /etc/environment

if ! getent group docker | grep -q "$USER"; then
    sudo usermod -aG docker "$USER"
fi
