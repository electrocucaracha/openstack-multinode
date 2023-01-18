#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2023
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

set -o errexit
set -o pipefail
if [[ ${OS_DEBUG:-false} == "true" ]]; then
    set -o xtrace
fi

export OS_DISTRO="${OS_DISTRO:-ubuntu}"
export VAGRANT_DISABLE_VBOXSYMLINKCREATE=1
export VAGRANT_EXPERIMENTAL=disks
export OS_KOLLA_RUN_INIT=false
export OS_KOLLA_ENABLE_HORIZON="no"
export OS_KOLLA_KOLLA_INSTALL_TYPE="source"

function info {
    _print_msg "INFO" "$1"
    echo "::notice::$1"
}

function warn {
    _print_msg "WARN" "$1"
    echo "::warning::$1"
}

function _print_msg {
    echo "$(date +%H:%M:%S) - $1: $2"
}

function get_release {
    local release_pointer=${CI_INITIAL_RELEASE_POINTER:-3}

    until [ -f "./requirements/$(sed -n "${release_pointer}p" releases.txt)/${OS_DISTRO}.txt" ]; do
        release_pointer=$((release_pointer - 1))
        if [[ $release_pointer -lt "0" ]]; then
            return
        fi
    done

    sed -n "${release_pointer}p" releases.txt
}

function upgrade {
    local initial_release=$1

    release_pointer=$(cat -n releases.txt | grep "$initial_release" | awk '{print $1}')
    release_pointer=$((release_pointer - 1))

    while [[ $release_pointer -gt "0" ]]; do
        release_name="$(sed -n "${release_pointer}p" releases.txt)"

        if [ -f "./requirements/${release_name}/${OS_DISTRO}.txt" ]; then
            pushd samples/aio/ >/dev/null
            info "Upgrading ${OS_DISTRO} distro to OpenStack ${release_name} release"
            vagrant ssh -- "cd /vagrant; OPENSTACK_RELEASE=$release_name OS_DEBUG=true ./upgrade.sh"
            print_hw_stats
            popd >/dev/null
        else
            warn "There is no more releases for ${OS_DISTRO} distro"
            break
        fi
        release_pointer=$((release_pointer - 1))
    done
}

function print_hw_stats {
    ! command -v vm_stat >/dev/null || vm_stat
    ! command -v VBoxManage >/dev/null || VBoxManage list runningvms --long
    ! command -v virsh >/dev/null || virsh list
}

initial_release=$(get_release)
if [[ -z $initial_release ]]; then
    warn "There is no OpenStack release supported for ${OS_DISTRO}"
    exit
fi
pushd samples/aio/ >/dev/null
info "Deploying ${OS_DISTRO} distro with OpenStack ${initial_release} release"
vagrant destroy -f
OPENSTACK_RELEASE="$initial_release" vagrant up
print_hw_stats
popd >/dev/null
upgrade "$initial_release"
