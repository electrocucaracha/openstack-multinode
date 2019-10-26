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
inventory_file=${OS_INVENTORY_FILE:-./inventory/hosts.ini}
kolla_folder=/opt/kolla-ansible
kolla_version=${OS_KOLLA_VERSION:-8.0.1}
kolla_tarball=kolla-ansible-$kolla_version.tar.gz
kolla_user=${OS_KOLLA_USER:-kolla}

sudo apt install -y python2.7 python-dev build-essential sshpass
curl -sL https://bootstrap.pypa.io/get-pip.py | sudo python

if [ ! -d ${kolla_folder} ]; then
    wget "http://tarballs.openstack.org/kolla-ansible/$kolla_tarball"
    sudo tar -C /opt -xzf "$kolla_tarball"
    rm "$kolla_tarball"
    sudo mv /opt/kolla-*/ $kolla_folder
fi
sudo cp $kolla_folder/etc/kolla/passwords.yml /etc/kolla/
sudo -E -H pip install --upgrade ansible
sudo -E -H pip install $kolla_folder

sudo -E -H pip install python-openstackclient

sudo mkdir -p /etc/ansible/
echo "[defaults]" | sudo tee /etc/ansible/ansible.cfg
echo "host_key_checking=False" | sudo tee --append /etc/ansible/ansible.cfg
echo "pipelinig=True" | sudo tee --append /etc/ansible/ansible.cfg
echo "forks=100" | sudo tee --append /etc/ansible/ansible.cfg

sudo kolla-genpwd
sudo rm -f /etc/docker/daemon.json
for action in bootstrap-servers prechecks pull deploy check post-deploy; do
    sudo kolla-ansible -vvv -i "$inventory_file" "$action" -e "ansible_user=${kolla_user}" -e 'ansible_become=true' -e 'ansible_become_method=sudo' | tee $action.log
done

# shellcheck disable=SC2002
cat /etc/kolla/admin-openrc.sh | sudo tee --append /etc/environment
