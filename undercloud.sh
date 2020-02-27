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

# Variables
kolla_folder=/opt/kolla-ansible
kolla_version=${OS_KOLLA_ANSIBLE_VERSION:-9.0.1}

pkgs="python-devel pip sshpass"
if ! command -v gcc; then
    pkgs+=" gcc"
fi
curl -fsSL http://bit.ly/install_pkg | PKG=$pkgs PKG_PYTHON_MAJOR_VERSION=2 bash

if [ ! -d ${kolla_folder} ]; then
    pushd "$(mktemp -d)"
    curl -o kolla-ansible.tar.gz "https://tarballs.opendev.org/openstack/kolla-ansible/kolla-ansible-${kolla_version}.tar.gz"
    tar -xzf kolla-ansible.tar.gz
    rm kolla-ansible.tar.gz
    sudo mv kolla-ansible-* "$kolla_folder"
    popd
fi

pip install --upgrade ansible
pip install $kolla_folder
pip install python-openstackclient

sudo mkdir -p /etc/{kolla,ansible}
sudo sed -i "s/^docker_registry: .*$/docker_registry: ${DOCKER_REGISTRY_IP:-127.0.0.1}:${DOCKER_REGISTRY_PORT:-5000}/g" /etc/kolla/globals.yml
sudo sed -i "s/^openstack_release: .*$/openstack_release: \"${OPENSTACK_RELEASE:-train}\"/g"  /etc/kolla/globals.yml

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
for action in bootstrap-servers prechecks pull deploy check post-deploy; do
    ./run_kaction.sh "$action"
done

# shellcheck disable=SC2002
cat /etc/kolla/admin-openrc.sh | sudo tee --append /etc/environment
