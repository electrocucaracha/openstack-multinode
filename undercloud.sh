#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2018,2023
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

set -o nounset
set -o pipefail
set -o errexit
if [[ ${OS_DEBUG:-false} == "true" ]]; then
    export PKG_DEBUG=true
    set -o xtrace
fi

source defaults.env
source commons.sh
# shellcheck disable=SC1091
source /etc/os-release || source /usr/lib/os-release

function _setup_proxy {
    if [ -n "${HTTP_PROXY-}" ]; then
        sed -i "s|^container_http_proxy: .*$|container_http_proxy: \"${HTTP_PROXY}\"|g" ~/.local/share/kolla-ansible/ansible/group_vars/all.yml
        echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/http-proxy.conf
        echo "Environment=\"HTTP_PROXY=$HTTP_PROXY\"" | sudo tee --append /etc/systemd/system/docker.service.d/http-proxy.conf
    fi
    if [ -n "${HTTPS_PROXY-}" ]; then
        sed -i "s|^container_https_proxy: .*$|container_https_proxy: \"${HTTPS_PROXY}\"|g" ~/.local/share/kolla-ansible/ansible/group_vars/all.yml
        echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/https-proxy.conf
        echo "Environment=\"HTTPS_PROXY=$HTTPS_PROXY\"" | sudo tee --append /etc/systemd/system/docker.service.d/https-proxy.conf
    fi
    if [ -n "${NO_PROXY-}" ]; then
        sed -i "s|^container_no_proxy: .*$|container_no_proxy: \"${NO_PROXY}\"|g" ~/.local/share/kolla-ansible/ansible/group_vars/all.yml
        echo "[Service]" | sudo tee /etc/systemd/system/docker.service.d/no-proxy.conf
        echo "Environment=\"NO_PROXY=$NO_PROXY\"" | sudo tee --append /etc/systemd/system/docker.service.d/no-proxy.conf
    fi
}

function _get_kolla_actions {
    local kolla_ansible_version="$1"
    local kolla_deploy_profile="${2:-$OS_KOLLA_DEPLOY_PROFILE}"

    kolla_actions=(bootstrap-servers)
    # Install Ansible Galaxy dependencies (Yoga release onwards)
    if vercmp "$kolla_ansible_version" '>=' '14'; then
        kolla_actions=(install-deps "${kolla_actions[@]}")
    fi
    if [ "${kolla_deploy_profile}" == "complete" ]; then
        kolla_actions=("${kolla_actions[@]}" prechecks pull)
    fi
    kolla_actions=("${kolla_actions[@]}" deploy)
    if [ "${kolla_deploy_profile}" == "complete" ] && vercmp "$kolla_ansible_version" '<' '15'; then
        # NOTE: Smoke tests have been removed in Zed release (https://github.com/openstack/kolla-ansible/commit/591f366ed736977664e899bd834e363191a9472d#diff-707286526f137598948e03470854d542446836f5dd83cbfcb30caab67bb6c7bb)
        kolla_actions=("${kolla_actions[@]}" check)
    fi
    kolla_actions=("${kolla_actions[@]}" post-deploy)

    echo "${kolla_actions[@]}"
}

function _remove_conflicting_python_pkgs {
    case ${ID,,} in
    ubuntu | debian)
        sanity_pkgs=""
        for pkg in python-cryptography python3-cryptography python3-distro-info python3-debian python3-openssl; do
            if sudo dpkg -l "$pkg" >/dev/null; then
                sanity_pkgs+="$pkg "
            fi
        done
        eval "sudo apt remove -y $sanity_pkgs"
        ;;
    esac
}

function _install_deps {
    _remove_conflicting_python_pkgs

    # Install dependencies
    curl -fsSL http://bit.ly/install_bin | PKG_BINDEP_PROFILE=undercloud PKG_COMMANDS_LIST="yq" bash

    # Install Kolla-Ansible dependencies
    sudo ln -s "$(command -v pip3)" /usr/bin/pip3 || :
    pip install --ignore-installed --no-warn-script-location --requirement "requirements/${OPENSTACK_RELEASE}/${ID,,}.txt"
    # PEP 370 -- Per user site-packages directory
    [[ $PATH != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin
    # https://review.opendev.org/#/c/584427/17/ansible/roles/rabbitmq/templates/rabbitmq-env.conf.j2@6
    sudo find / -name rabbitmq-env.conf.j2 -exec sed -i '/export ERL_EPMD_ADDRESS/d' {} \;
}

function _setup_ansible {
    # Setup Mitogen
    mitogen_ansible_cfg=""
    if pip freeze | grep -q mitogen; then
        mitogen_ansible_cfg="
strategy = mitogen_linear
strategy_plugins = $(dirname "$(sudo find / -name mitogen_linear.py | head -n 1)")

"
    fi

    sudo tee /etc/ansible/ansible.cfg <<EOL
[defaults]
host_key_checking=False
remote_tmp=/tmp/
callbacks_enabled = timer, profile_tasks
$mitogen_ansible_cfg
[ssh_connection]
pipelinig=True
ssh_args = -o ControlMaster=auto -o ControlPersist=30m -o ConnectionAttempts=100 -o UserKnownHostsFile=/dev/null
EOL
    if [[ ${OS_DEBUG:-false} == "true" ]]; then
        # Print out Ansible configuration
        ansible-config dump --only-changed
    fi
}

function _cleanup_docker_services {
    # Remove docker source list to avoid update conflicts
    [[ $PATH != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin
    ansible control -i "${OS_INVENTORY_FILE:-./samples/aio/hosts.ini}" -m file \
        -a 'path=/etc/apt/sources.list.d/docker.list state=absent' -b \
        -e "ansible_user=$USER"
    sudo rm -f /etc/docker/daemon.json
}

function _run_kolla_ansible {
    # PEP 370 -- Per user site-packages directory
    [[ $PATH != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin
    kolla-genpwd
    kolla_ansible_version="$(pip freeze | grep kolla-ansible | sed 's/^.*=//')"
    # shellcheck disable=SC2046
    run_kolla_actions $(_get_kolla_actions "$kolla_ansible_version")
    sudo chown "$USER" /etc/kolla/admin-openrc.sh
    # shellcheck disable=SC2002
    cat /etc/kolla/admin-openrc.sh | sudo tee --append /etc/environment
}

function main {
    sudo touch /etc/timezone

    _start=$(date +%s)
    trap 'printf "Provisioning process: %s secs\n" "$(($(date +%s)-_start))"' EXIT

    _install_deps
    sudo mkdir -p /etc/{kolla,ansible,systemd/system/docker.service.d}

    # Setup configuration values
    if [ "${OS_ENABLE_LOCAL_REGISTRY:-false}" == "true" ]; then
        export OS_KOLLA_DOCKER_REGISTRY="${DOCKER_REGISTRY_IP:-127.0.0.1}:${DOCKER_REGISTRY_PORT:-5000}"
        export OS_KOLLA_DOCKER_REGISTRY_INSECURE="yes"
        export OS_KOLLA_DOCKER_NAMESPACE="kolla"
    fi
    set_values
    _setup_proxy
    _setup_ansible

    _cleanup_docker_services

    _run_kolla_ansible

    if groups | grep -q docker && (! getent group docker | grep -q "$USER"); then
        sudo usermod -aG docker "$USER"
    fi
}

if [[ ${__name__:-"__main__"} == "__main__" ]]; then
    main
fi
