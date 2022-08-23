#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2022
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

set -o nounset
set -o pipefail
set -o errexit
if [[ ${OS_DEBUG:-false} == "true" ]]; then
    set -o xtrace
fi
set -o xtrace

source defaults.env
source commons.sh
# shellcheck disable=SC1091
source /etc/os-release || source /usr/lib/os-release

# PEP 370 -- Per user site-packages directory
[[ $PATH != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin

function print_state {
    if command -v openstack; then
        echo "OpenStack client version"
        openstack --version

        echo "OpenStack service versions"
        openstack versions show
    fi

    echo "OpenStack Kolla version"
    pip freeze | grep kolla

    if command -v docker; then
        echo "OpenStack Kolla services"
        sudo docker ps
    fi
}

if ! command -v pip; then
    # NOTE: Shorten link -> https://github.com/electrocucaracha/pkg-mgr_scripts
    curl -fsSL http://bit.ly/install_pkg | PKG=pip bash
fi

print_state
trap print_state EXIT

echo "Upgrade OpenStack services to ${OPENSTACK_RELEASE} release"
pip install --ignore-installed --no-warn-script-location --requirement "requirements/${OPENSTACK_RELEASE}/${ID,,}.txt"

echo "Configure values of globals.yml file"
set_values

for action in pull upgrade; do
    ./run_kaction.sh "$action" | tee "$HOME/upgrade-$action.log"
    echo "Kolla Action statistics:"
    grep ': .* -* .*s$' "$HOME/upgrade-$action.log" || :
done
