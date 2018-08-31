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

# configure_docker_proxy() - Configures Proxy settings for Docker service
function configure_docker_proxy {
    if [ $http_proxy ]; then
        cat <<EOL > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=$http_proxy"
EOL
    fi
    if [ $https_proxy ]; then
        cat <<EOL > /etc/systemd/system/docker.service.d/https-proxy.conf
[Service]
Environment="HTTPS_PROXY=$https_proxy"
EOL
    fi
    if [ $no_proxy ]; then
        cat <<EOL > /etc/systemd/system/docker.service.d/no-proxy.conf
[Service]
Environment="NO_PROXY=$no_proxy"
EOL
    fi
    systemctl daemon-reload
    usermod -aG docker $USER

    systemctl restart docker
    sleep 10
}

apt remove -y python-pip
apt-get install -y python-dev
curl -sL https://bootstrap.pypa.io/get-pip.py | sudo python

# Get Kolla source code
wget http://tarballs.openstack.org/kolla/$kolla_tarball
tar -C /opt -xzf $kolla_tarball
mv /opt/kolla-*/ $kolla_folder

bash $kolla_folder/tools/setup_Debian.sh
configure_docker_proxy

# Start local registry
bash $kolla_folder/tools/start-registry

# Kolla Docker images creation
pip install $kolla_folder
kolla-build --config-file /etc/kolla/kolla-build.conf
