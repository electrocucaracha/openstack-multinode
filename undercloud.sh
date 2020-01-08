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
kolla_version=${OS_KOLLA_VERSION:-9.0.0}

curl -fsSL http://bit.ly/pkgInstall | PKG="pip sshpass" bash

if [ ! -d ${kolla_folder} ]; then
    pushd "$(mktemp -d)"
    curl -o kolla-ansible.tar.gz "http://tarballs.openstack.org/kolla-ansible/kolla-ansible-$kolla_version.tar.gz"
    tar -xzf kolla-ansible.tar.gz
    rm kolla-ansible.tar.gz
    sudo mv kolla-ansible-${kolla_version} $kolla_folder
    popd
fi

sudo -E -H pip install --upgrade ansible
sudo -E -H pip install $kolla_folder
sudo -E -H pip install python-openstackclient

sudo mkdir -p /etc/{kolla,ansible}
sudo cp etc/kolla-ansible/globals.yml /etc/kolla/
sudo cp $kolla_folder/etc/kolla/passwords.yml /etc/kolla/
sudo sed -i "s/^openstack_release: .*/openstack_release: \"${OPENSTACK_RELEASE:-train}\"/g"  /etc/kolla/globals.yml

echo "[defaults]" | sudo tee /etc/ansible/ansible.cfg
echo "host_key_checking=False" | sudo tee --append /etc/ansible/ansible.cfg
echo "pipelinig=True" | sudo tee --append /etc/ansible/ansible.cfg
echo "forks=100" | sudo tee --append /etc/ansible/ansible.cfg
echo "remote_tmp=/tmp/" | sudo tee --append /etc/ansible/ansible.cfg

sudo kolla-genpwd
sudo rm -f /etc/docker/daemon.json
for action in bootstrap-servers prechecks pull deploy check post-deploy; do
    sudo kolla-ansible -vvv -i "${OS_INVENTORY_FILE:-./inventory/hosts.ini}" "$action" -e "ansible_user=${OS_KOLLA_USER:-kolla}" -e 'ansible_become=true' -e 'ansible_become_method=sudo' | tee ~/$action.log
done

# shellcheck disable=SC2002
cat /etc/kolla/admin-openrc.sh | sudo tee --append /etc/environment
