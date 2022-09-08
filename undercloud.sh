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
if [[ ${OS_DEBUG:-false} == "true" ]]; then
    export PKG_DEBUG=true
    set -o xtrace
fi

source defaults.env
source commons.sh

sudo touch /etc/timezone

_start=$(date +%s)
trap 'printf "Provisioning process: %s secs\n" "$(($(date +%s)-_start))"' EXIT

# Install dependencies
curl -fsSL http://bit.ly/install_bin | PKG_BINDEP_PROFILE=undercloud PKG_COMMANDS_LIST="yq" bash

# shellcheck disable=SC1091
source /etc/os-release || source /usr/lib/os-release
case ${ID,,} in
ubuntu | debian)
    sanity_pkgs=""
    for pkg in python-cryptography python3-distro-info python3-debian; do
        if sudo dpkg -l "$pkg" >/dev/null; then
            sanity_pkgs+="$pkg "
        fi
    done
    eval "sudo apt remove -y $sanity_pkgs"
    ;;
esac

sudo ln -s "$(command -v pip3)" /usr/bin/pip3 || :
pip install --ignore-installed --no-warn-script-location --requirement "requirements/${OPENSTACK_RELEASE}/${ID,,}.txt"
# PEP 370 -- Per user site-packages directory
[[ $PATH != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin
# https://review.opendev.org/#/c/584427/17/ansible/roles/rabbitmq/templates/rabbitmq-env.conf.j2@6
sudo find / -name rabbitmq-env.conf.j2 -exec sed -i '/export ERL_EPMD_ADDRESS/d' {} \;

sudo mkdir -p /etc/{kolla,ansible,systemd/system/docker.service.d}
if [ "${OS_ENABLE_LOCAL_REGISTRY:-false}" == "true" ]; then
    export OS_KOLLA_DOCKER_REGISTRY="${DOCKER_REGISTRY_IP:-127.0.0.1}:${DOCKER_REGISTRY_PORT:-5000}"
    export OS_KOLLA_DOCKER_REGISTRY_INSECURE="yes"
    export OS_KOLLA_DOCKER_NAMESPACE="kolla"
fi
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
set_values

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

# Print out Ansible configuration
ansible-config dump --only-changed

# Remove docker source list to avoid update conflicts
[[ $PATH != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin
ansible control -i "${OS_INVENTORY_FILE:-./samples/aio/hosts.ini}" -m file \
    -a 'path=/etc/apt/sources.list.d/docker.list state=absent' -b \
    -e "ansible_user=$USER"

# PEP 370 -- Per user site-packages directory
[[ $PATH != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin

kolla-genpwd
sudo rm -f /etc/docker/daemon.json
kolla_actions=(bootstrap-servers prechecks pull deploy check post-deploy)
if [ "${OS_KOLLA_DEPLOY_PROFILE:-complete}" == "minimal" ]; then
    kolla_actions=(bootstrap-servers deploy post-deploy)
fi
# Install Ansible Galaxy dependencies (Yoga release onwards)
if vercmp "$(pip freeze | grep kolla-ansible | sed 's/^.*=//')" '>=' '14'; then
    kolla_actions=(install-deps "${kolla_actions[@]}")
fi
for action in "${kolla_actions[@]}"; do
    ./run_kaction.sh "$action" | tee "$HOME/$action.log"
    echo "Kolla Action statistics:"
    grep ': .* -* .*s$' "$HOME/$action.log" || :
done
case ${ID,,} in
ubuntu | debian)
    if sudo dpkg -l python3-cryptography >/dev/null; then
        sudo apt remove -y python3-cryptography
    fi
    sudo apt-get autoremove -y
    ;;
esac

sudo chown "$USER" /etc/kolla/admin-openrc.sh
# shellcheck disable=SC2002
cat /etc/kolla/admin-openrc.sh | sudo tee --append /etc/environment

if groups | grep -q docker && (! getent group docker | grep -q "$USER"); then
    sudo usermod -aG docker "$USER"
fi
