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
openstack_release="queens"
inventory_file=/vagrant/inventory/hosts.ini

apt install -y python2.7 python-dev build-essential sshpass
curl -sL https://bootstrap.pypa.io/get-pip.py | sudo python

for repo in kolla kolla-ansible; do
    git clone https://github.com/openstack/$repo
    pushd $repo
#    git checkout -b $openstack_release origin/stable/$openstack_release
    pip install .
    popd
done
pip install python-openstackclient

mkdir -p /etc/ansible/
cat << EOLF > /etc/ansible/ansible.cfg
[defaults]
host_key_checking=False
pipelining=True
forks=100
EOLF

kolla-genpwd
ansible -i $inventory_file all -m ping
for action in bootstrap-servers prechecks deploy post-deploy; do
    kolla-ansible -vvv -i $inventory_file $action | tee $action.log
done
echo "source /etc/kolla/admin-openrc.sh" >> .profile
