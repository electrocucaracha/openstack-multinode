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
set -o xtrace

kolla_folder=/opt/kolla/
kolla_version=stable-rocky
kolla_tarball=kolla-$kolla_version.tar.gz

# configure_docker_proxy() - Configures Proxy settings for Docker service
function configure_docker_proxy {
    bifrost_header=""
    bifrost_footer=""
    if [[ "${HTTP_PROXY+x}" = "x"  ]]; then
        echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf
        echo "Environment=\"HTTP_PROXY=$HTTP_PROXY\"" | sudo tee --append /etc/systemd/system/docker.service.d/http-proxy.conf
        bifrost_header+="ENV http_proxy=$HTTP_PROXY\n"
        bifrost_footer+="ENV http_proxy=\"\"\n"
    fi
    if [[ "${HTTPS_PROXY+x}" = "x" ]]; then
        echo "Environment=\"HTTPS_PROXY=$HTTPS_PROXY\"" | sudo tee --append /etc/systemd/system/docker.service.d/http-proxy.conf
        bifrost_header+="ENV https_proxy=$HTTPS_PROXY\n"
        bifrost_footer+="ENV https_proxy=\"\"\n"
    fi
    if [[ "${NO_PROXY+x}" = "x" ]]; then
        echo "Environment=\"NO_PROXY=$NO_PROXY\"" | sudo tee --append /etc/systemd/system/docker.service.d/http-proxy.conf
        bifrost_header+="ENV no_proxy=$NO_PROXY\n"
        bifrost_footer+="ENV no_proxy=\"\"\n"
    fi
    sudo systemctl daemon-reload
    sudo systemctl restart docker
    sleep 10

    if groups | grep -q docker; then
        sudo usermod -aG docker "$USER"
    fi

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

# shellcheck disable=SC1091
source /etc/os-release || source /usr/lib/os-release

case ${ID,,} in
    ubuntu|debian)
        sudo apt remove -y python-pip
        sudo apt-get install -y python-dev
    ;;
    clear-linux-os)
    ;;
esac
curl -sL https://bootstrap.pypa.io/get-pip.py | sudo python

# Get Kolla source code
wget http://tarballs.openstack.org/kolla/$kolla_tarball
sudo tar -C /tmp -xzf $kolla_tarball
sudo rm -rf $kolla_folder
sudo mv /tmp/kolla-*/ $kolla_folder
rm $kolla_tarball

cd $kolla_folder
sudo rm -rf /etc/systemd/system/docker.service.d

case ${ID,,} in
    ubuntu|debian)
        ./tools/setup_Debian.sh
    ;;
    rhel|centos|fedora)
        ./tools/setup_RedHat.sh
    ;;
    clear-linux-os)
    ;;
esac
configure_docker_proxy

# Start local registry
if [[ -z $(sudo docker ps -aqf "name=registry") ]]; then
    sudo ./tools/start-registry
fi

# Kolla Docker images creation
sudo pip install .
sudo mkdir -p /var/log/kolla
sudo kolla-build --config-file /etc/kolla/kolla-build.ini --logs-dir /var/log/kolla
#kolla-build --type source --template-override template-overrides.j2 bifrost-deploy
