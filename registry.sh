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

kolla_version=${OS_KOLLA_VERSION:-8.0.1}
openstack_release=${OPENSTACK_RELEASE:-stein}
docker_registry_port=${DOCKER_REGISTRY_PORT:-5000}

# install_docker() - Download and install docker-engine
function install_docker {
    local bifrost_header=""
    local bifrost_footer=""

    if command -v docker; then
        return
    fi

    echo "Installing docker service..."

    # shellcheck disable=SC1091
    source /etc/os-release || source /usr/lib/os-release
    case ${ID,,} in
        clear-linux-os)
            sudo -E swupd bundle-add ansible
            sudo systemctl unmask docker.service
        ;;
        *)
            curl -fsSL https://get.docker.com/ | sh
        ;;
    esac

    sudo mkdir -p /etc/systemd/system/docker.service.d
    mkdir -p "$HOME/.docker/"
    sudo mkdir -p /root/.docker/
    sudo usermod -aG docker "$USER"
    if [ -n "${SOCKS_PROXY:-}" ]; then
        socks_tmp="${SOCKS_PROXY#*//}"
        curl -sSL https://raw.githubusercontent.com/crops/chameleonsocks/master/chameleonsocks.sh | sudo PROXY="${socks_tmp%:*}" PORT="${socks_tmp#*:}" bash -s -- --install
    else
        if [ -n "${HTTP_PROXY:-}" ]; then
            echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf
            echo "Environment=\"HTTP_PROXY=$HTTP_PROXY\"" | sudo tee --append /etc/systemd/system/docker.service.d/http-proxy.conf
        fi
        if [ -n "${HTTPS_PROXY:-}" ]; then
            echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/https-proxy.conf
            echo "Environment=\"HTTPS_PROXY=$HTTPS_PROXY\"" | sudo tee --append /etc/systemd/system/docker.service.d/https-proxy.conf
        fi
        if [ -n "${NO_PROXY:-}" ]; then
            echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/no-proxy.conf
            echo "Environment=\"NO_PROXY=$NO_PROXY\"" | sudo tee --append /etc/systemd/system/docker.service.d/no-proxy.conf
        fi
    fi
    if [ -n "${HTTP_PROXY:-}" ] || [ -n "${HTTPS_PROXY:-}" ] || [ -n "${NO_PROXY:-}" ]; then
        config="{ \"proxies\": { \"default\": { "
        if [ -n "${HTTP_PROXY:-}" ]; then
            config+="\"httpProxy\": \"$HTTP_PROXY\","
            bifrost_header+="ENV http_proxy=$HTTP_PROXY\n"
            bifrost_footer+="ENV http_proxy=\"\"\n"
        fi
        if [ -n "${HTTPS_PROXY:-}" ]; then
            config+="\"httpsProxy\": \"$HTTPS_PROXY\","
            bifrost_header+="ENV https_proxy=$HTTPS_PROXY\n"
            bifrost_footer+="ENV https_proxy=\"\"\n"
        fi
        if [ -n "${NO_PROXY:-}" ]; then
            config+="\"noProxy\": \"$NO_PROXY\","
            bifrost_header+="ENV no_proxy=$NO_PROXY\n"
            bifrost_footer+="ENV no_proxy=\"\"\n"
        fi
        echo "${config::-1} } } }" | tee "$HOME/.docker/config.json"
        sudo cp "$HOME/.docker/config.json" /root/.docker/config.json
    fi
    sudo tee /etc/docker/daemon.json << EOF
{
  "insecure-registries" : ["0.0.0.0/0"]
}
EOF
    sudo systemctl daemon-reload
    sudo systemctl restart docker

    cat <<EOL > "$HOME/template-overrides.j2"
{% extends parent_template %}

{% block bifrost_base_header %}
$bifrost_header
{% endblock %}

{% block bifrost_base_footer %}
$bifrost_footer
{% endblock %}
EOL

    printf "Waiting for docker service..."
    until sudo docker info; do
        printf "."
        sleep 2
    done
}

# shellcheck disable=SC1091
source /etc/os-release || source /usr/lib/os-release
case ${ID,,} in
    ubuntu|debian)
        sudo apt remove -y python-pip
        sudo apt-get install -y python-dev
    ;;
esac
curl -sL https://bootstrap.pypa.io/get-pip.py | sudo python

sudo -H -E pip install kolla=="${kolla_version}"
install_docker

# Start local registry
if [[ -z $(sudo docker ps -aqf "name=registry") ]]; then
    sudo -E docker run -d --name registry --restart=always \
    -p "${docker_registry_port}":5000 -v registry:/var/lib/registry registry:2
fi

# Configure custom values
sudo sed -i "s/^tag = .*/tag = ${openstack_release}/g" /etc/kolla/kolla-build.ini

# Kolla Docker images creation
sudo kolla-build --config-file /etc/kolla/kolla-build.ini | tee output.json
if [[ $(jq  '.failed | length ' output.json) != 0 ]]; then
    jq  '.failed[].name' output.json
    exit 1
fi
#kolla-build --type source --template-override $HOME/template-overrides.j2 bifrost-deploy
