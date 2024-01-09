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

function _print_state {
    # PEP 370 -- Per user site-packages directory
    [[ $PATH != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin
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

function _install_deps {
    if ! command -v pip; then
        # NOTE: Shorten link -> https://github.com/electrocucaracha/pkg-mgr_scripts
        curl -fsSL http://bit.ly/install_pkg | PKG=pip bash
    fi
    echo "Upgrade OpenStack services to ${OPENSTACK_RELEASE} release"
    # NOTE: Uninstall mitogen given that it's only supported in some Ansible versions (2.13.x)
    pip uninstall mitogen --yes
    pip install --ignore-installed --no-warn-script-location --requirement "requirements/${OPENSTACK_RELEASE}/${ID,,}_${VERSION_ID%.*}.txt"
    setup_ansible
}

function main {
    _print_state
    trap _print_state EXIT

    _install_deps
    set_values
    run_kolla_actions pull upgrade
}

if [[ ${__name__:-"__main__"} == "__main__" ]]; then
    main
fi
