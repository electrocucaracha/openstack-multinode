#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2018
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

apt-get update
apt install -y software-properties-common linux-image-extra-$(uname -r) linux-image-extra-virtual
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable"
apt update
apt install -y docker-ce python2.7 python-dev build-essential

curl -sL https://bootstrap.pypa.io/get-pip.py | sudo python
git clone https://github.com/openstack/kolla
pushd kolla
pip install .

pip install tox
tox -e genconfig
kolla-build --config-file etc/kolla/kolla-build.conf
popd
