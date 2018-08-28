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
set -o xtrace

kolla_folder=/opt/kolla
kolla_version=master
kolla_tarball=kolla-$kolla_version.tar.gz

docker run -d --name registry --restart=always -p 5000:5000 -v registry:/var/lib/registry registry:2
curl -sL https://bootstrap.pypa.io/get-pip.py | sudo python
wget http://tarballs.openstack.org/kolla/$kolla_tarball
tar -C /opt -xzf $kolla_tarball
mv /opt/kolla-*/ $kolla_folder
pip install $kolla_folder

kolla-build --config-file /vagrant/etc/kolla-build.conf
