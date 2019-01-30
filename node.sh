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

# Configuration
cd $OPENSTACK_SCRIPTS_DIR

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

    sudo sfdisk $dev_name --no-reread << EOF
;
EOF
    sudo mkfs -t ext4 ${dev_name}1
    sudo mkdir -p $mount_dir
    sudo mount ${dev_name}1 $mount_dir
    echo "${dev_name}1 $mount_dir           ext4    errors=remount-ro,noatime,barrier=0 0       1" | sudo tee --append /etc/fstab
}

while getopts "h?v:" opt; do
    case $opt in
        v)
            dict_volumes="$OPTARG"
            ;;
        h|\?)
            usage
            exit
            ;;
    esac
done

sudo swapoff -a
if [[ -n "${dict_volumes+x}" ]]; then
    for kv in ${dict_volumes//,/ } ;do
        mount_external_partition ${kv%=*} ${kv#*=}
    done
fi

vendor_id=$(lscpu|grep "Vendor ID")
if [[ $vendor_id == *GenuineIntel* ]]; then
    kvm_ok=$(cat /sys/module/kvm_intel/parameters/nested)
    if [[ $kvm_ok == 'N' ]]; then
        echo "Enable Intel Nested-Virtualization"
        sudo rmmod kvm-intel
        echo 'options kvm-intel nested=y' | sudo tee --append /etc/modprobe.d/dist.conf
        sudo modprobe kvm-intel
        echo kvm-intel |sudo tee --append /etc/modules
    fi
else
    kvm_ok=$(cat /sys/module/kvm_amd/parameters/nested)
    if [[ $kvm_ok == '0' ]]; then
        echo "Enable AMD Nested-Virtualization"
        sudo rmmod kvm-amd
        echo 'options kvm-amd nested=1' | sudo tee --append /etc/modprobe.d/dist.conf
        sudo modprobe kvm-amd
        echo kvm-amd | sudo tee --append /etc/modules
    fi
fi
sudo modprobe vhost_net
echo vhost_net | sudo tee --append /etc/modules
source /etc/os-release || source /usr/lib/os-release
case ${ID,,} in
    *suse)
    ;;
    ubuntu|debian)
        sudo apt-get install -y cpu-checker
        kvm-ok
    ;;
    rhel|centos|fedora)
    ;;
esac

# Setup proxy variables
if [ -f sources.list ]; then
    sudo cp sources.list /etc/apt/sources.list
fi
#sudo apt-get update
#sudo apt-get -y install python-dev
#if [[ $(groups | grep docker) ]]; then
#    getent group docker || groupadd docker
#    sudo usermod -aG docker $USER
#fi

for role in $OPENSTACK_NODE_ROLES; do
    if [ -f $role.sh ]; then
        sudo ./$role.sh
    fi
done
