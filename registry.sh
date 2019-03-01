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
set -o errexit

kolla_folder=/opt/kolla
kolla_version=stable-rocky
kolla_tarball=kolla-$kolla_version.tar.gz

# configure_docker_proxy() - Configures Proxy settings for Docker service
function configure_docker_proxy {
    bifrost_header=""
    bifrost_footer=""
    if [[ "${HTTP_PROXY+x}" = "x"  ]]; then
        cat <<EOL > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=$HTTP_PROXY"
EOL
        bifrost_header+="ENV http_proxy=$HTTP_PROXY\n"
        bifrost_footer+="ENV http_proxy=\"\"\n"
    fi
    if [[ "${HTTPS_PROXY+x}" = "x" ]]; then
        cat <<EOL > /etc/systemd/system/docker.service.d/https-proxy.conf
[Service]
Environment="HTTPS_PROXY=$HTTPS_PROXY"
EOL
        bifrost_header+="ENV https_proxy=$HTTPS_PROXY\n"
        bifrost_footer+="ENV https_proxy=\"\"\n"
    fi
    if [[ "${NO_PROXY+x}" = "x" ]]; then
        cat <<EOL > /etc/systemd/system/docker.service.d/no-proxy.conf
[Service]
Environment="NO_PROXY=$NO_PROXY"
EOL
        bifrost_header+="ENV no_proxy=$NO_PROXY\n"
        bifrost_footer+="ENV no_proxy=\"\"\n"
    fi
    systemctl daemon-reload

    systemctl restart docker
    sleep 10

    cat <<EOL > template-overrides.j2
{% extends parent_template %}

{% block bifrost_base_header %}
$bifrost_header
{% endblock %}

{% block bifrost_base_footer %}
$bifrost_footer
{% endblock %}
EOL
}

apt remove -y python-pip
apt-get install -y python-dev
curl -sL https://bootstrap.pypa.io/get-pip.py | sudo python

# Get Kolla source code
wget http://tarballs.openstack.org/kolla/$kolla_tarball
tar -C /opt -xzf $kolla_tarball
mv /opt/kolla-*/ $kolla_folder
rm $kolla_tarball

cd $kolla_folder
rm -rf /etc/systemd/system/docker.service.d
./tools/setup_Debian.sh
configure_docker_proxy

# Start local registry
if [[ -z $(docker ps -aqf "name=registry") ]]; then
    ./tools/start-registry
fi

# Kolla Docker images creation
pip install .
mkdir -p /var/log/kolla
kolla-build --config-file /etc/kolla/kolla-build.ini --logs-dir /var/log/kolla
#kolla-build --type source --template-override template-overrides.j2 bifrost-deploy
