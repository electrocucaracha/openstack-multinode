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
set -o xtrace

# usage() - Prints the usage of the program
function usage {
    cat <<EOF
usage: $0 [-v volumes]
Optional Argument:
    -v List of key pair values for volumes and mount points ( e. g. sda=/var/lib/docker/,sdb=/var/lib/libvirt/ )
EOF
}

# install_docker() - Installs Docker service
function install_docker {
    local max_concurrent_downloads=${1:-3}

    if $(docker version &>/dev/null); then
        return
    fi
    apt-get install -y software-properties-common linux-image-extra-$(uname -r) linux-image-extra-virtual apt-transport-https ca-certificates curl
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce

    mkdir -p /etc/systemd/system/docker.service.d
cat <<EOL > /etc/systemd/system/docker.service.d/kolla.conf
[Service]
MountFlags=shared
EOL
    if [ $http_proxy ]; then
        cat <<EOL > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=$http_proxy"
EOL
    fi
    if [ $https_proxy ]; then
        cat <<EOL > /etc/systemd/system/docker.service.d/https-proxy.conf
[Service]
Environment="HTTPS_PROXY=$https_proxy"
EOL
    fi
    if [ $no_proxy ]; then
        cat <<EOL > /etc/systemd/system/docker.service.d/no-proxy.conf
[Service]
Environment="NO_PROXY=$no_proxy"
EOL
    fi
    systemctl daemon-reload
    echo "DOCKER_OPTS=\"-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --max-concurrent-downloads $max_concurrent_downloads --insecure-registry 10.10.13.2:5000\"" >> /etc/default/docker
    usermod -aG docker $USER

    systemctl restart docker
    sleep 10
}

# mount_external_partition() - Create partition and mount the external volume
function mount_external_partition {
    local dev_name="/dev/$1"
    local mount_dir=$2

    sfdisk $dev_name --no-reread << EOF
;
EOF
    mkfs -t ext4 ${dev_name}1
    mkdir -p $mount_dir
    mount ${dev_name}1 $mount_dir
    echo "${dev_name}1 $mount_dir           ext4    errors=remount-ro,noatime,barrier=0 0       1" >> /etc/fstab
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

swapoff -a
if [[ -n "${dict_volumes+x}" ]]; then
    for kv in ${dict_volumes//,/ } ;do
        mount_external_partition ${kv%=*} ${kv#*=}
    done
fi

# Setup proxy variables
if [ -f /vagrant/sources.list ]; then
    sudo cp /vagrant/sources.list /etc/apt/sources.list
fi
install_docker
