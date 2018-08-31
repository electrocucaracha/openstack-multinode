#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2018
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

set -o nounset
set -o pipefail

# Variables
inventory_file=/vagrant/inventory/hosts.ini
kolla_folder=/opt/kolla-ansible
kolla_version=master
kolla_tarball=kolla-ansible-$kolla_version.tar.gz

# Setup proxy variables
if [ -f /vagrant/sources.list ]; then
    cat /vagrant/sources.list >> /etc/apt/sources.list
fi

apt install -y python2.7 python-dev build-essential sshpass
curl -sL https://bootstrap.pypa.io/get-pip.py | sudo python

wget http://tarballs.openstack.org/kolla-ansible/$kolla_tarball
tar -C /opt -xzf $kolla_tarball
mv /opt/kolla-*/ $kolla_folder
cp $kolla_folder/etc/kolla/passwords.yml /etc/kolla/
pip install $kolla_folder

pip install python-openstackclient

mkdir -p /etc/ansible/
cat << EOLF > /etc/ansible/ansible.cfg
[defaults]
host_key_checking=False
pipelining=True
forks=100
EOLF

kolla-genpwd
#ansible -i $inventory_file all -m raw -a "sudo apt-get -y install python-dev"
for action in bootstrap-servers prechecks deploy post-deploy; do
    kolla-ansible -vvv -i $inventory_file $action | tee $action.log
    if [[ "$action" == "bootstrap-servers" ]]; then
        ansible -i $inventory_file all -m raw -a "sudo usermod -aG docker vagrant"
    fi
done
