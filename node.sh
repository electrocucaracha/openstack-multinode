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

# shellcheck disable=SC1091
source /etc/os-release || source /usr/lib/os-release

_start=$(date +%s)
trap 'printf "Node setup process: %s secs\n" "$(($(date +%s)-_start))"' EXIT

# usage() - Prints the usage of the program
function usage {
    cat <<EOF
usage: $0 [-v volumes]
Optional Argument:
    -v List of key pair values for volumes and mount points ( e. g. sda=/var/lib/docker/,sdb=/var/lib/libvirt/ )
EOF
}

# mount_external_partition() - Create partition and mount the external volume
function mount_external_partition {
    local dev_name="/dev/$1"
    local mount_dir=$2

    if ! command -v sfdisk >/dev/null; then
        case ${ID,,} in
        ubuntu | debian)
            sudo apt-get update -qq >/dev/null
            sudo apt-get install -y -qq -o=Dpkg::Use-Pty=0 fdisk
            ;;
        esac
    fi

    sudo sfdisk "$dev_name" --no-reread <<EOF
;
EOF
    sudo mkfs -t ext4 "${dev_name}1"
    sudo mkdir -p "$mount_dir"
    sudo mount "${dev_name}1" "$mount_dir"
    echo "${dev_name}1 $mount_dir           ext4    errors=remount-ro,noatime,barrier=0 0       1" | sudo tee --append /etc/fstab
}

while getopts "h?v:c:" opt; do
    case $opt in
    v)
        dict_volumes="$OPTARG"
        ;;
    c)
        cinder_volumes="$OPTARG"
        ;;
    h | \?)
        usage
        exit
        ;;
    esac
done

if [ "${ID,,}" == "ubuntu" ]; then
    sudo apt-get install -y -qq -o=Dpkg::Use-Pty=0 "linux-modules-extra-$(uname -r)"
fi

if ! command -v cloud-init >/dev/null; then
    case ${ID,,} in
    ubuntu | debian)
        sudo apt-get -y -qq purge cloud-init
        ;;
    esac
fi

if [ -n "${dict_volumes-}" ]; then
    for kv in ${dict_volumes//,/ }; do
        mount_external_partition "${kv%=*}" "${kv#*=}"
    done
fi

if [ -n "${cinder_volumes-}" ]; then
    if ! command -v vgs; then
        curl -fsSL http://bit.ly/install_pkg | PKG="lvm2" bash
    fi
    # Ensure that the volume is empty
    sudo dd if=/dev/zero of="$cinder_volumes" bs=512 count=1

    # Creation of cinder LVM
    sudo vgcreate cinder-volumes "$cinder_volumes"
    sudo vgs
    sudo pvdisplay

    # Configure LVM to only scan devices that contain the cinder-volumes volume group
    filter_string=""
    for pv_info in $(sudo pvs --noheadings -o name); do
        filter_string+="\"a|${pv_info##*/}|\", "
    done
    # shellcheck disable=SC1003
    sudo sed -i -e '/# global_filter = \[.*\]/a\' -e "\tglobal_filter = [ $filter_string \"r|.*|\" ]" /etc/lvm/lvm.conf

    sudo modprobe dm_thin_pool
    echo "dm_thin_pool" | sudo tee /etc/modules-load.d/dm_thin_pool.conf
    sudo modprobe target_core_mod
    echo "target_core_mod" | sudo tee /etc/modules-load.d/target_core_mod.conf
fi

if [[ -n ${OPENSTACK_NODE_ROLES+x} ]]; then
    for role in $OPENSTACK_NODE_ROLES; do
        if [ -f "$role.sh" ]; then
            bash "$role.sh" | sudo tee "$HOME/$role.log"
        fi
    done
fi
curl -fsSL http://bit.ly/install_bin | PKG_BINDEP_PROFILE=node bash
