#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2020
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

fedora_image_file="$HOME/Fedora-Cloud.qcow2"
os_glance_image=fedora-atomic
os_magnum_template=kubernetes-cluster-template
os_magnum_cluster=${1:-kubernetes-cluster}

# PEP 370 -- Per user site-packages directory
[[ $PATH != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin

# NOTE: Shorten link -> https://github.com/electrocucaracha/pkg-mgr_scripts
curl -fsSL http://bit.ly/install_pkg | PKG_COMMANDS_LIST="pip,kubectl" bash

if ! command -v magnum; then
    pip install python-magnumclient
fi

if [ ! -f "$fedora_image_file" ]; then
    curl -o "$fedora_image_file" -sL https://download.fedoraproject.org/pub/fedora/linux/releases/32/Cloud/x86_64/images/Fedora-Cloud-Base-32-1.6.x86_64.qcow2
fi

if ! openstack image list --name "$os_glance_image" | grep -q "$os_glance_image"; then
    openstack image create --disk-format=qcow2 --container-format=bare \
        --file="$fedora_image_file" --property os_distro='fedora-atomic' \
        "$os_glance_image"
fi

if ! openstack coe cluster template list | grep -q "$os_magnum_template"; then
    openstack coe cluster template create "$os_magnum_template" \
        --image "$os_glance_image" --external-network public1 \
        --dns-nameserver 8.8.8.8 --master-flavor m1.small \
        --flavor m1.small --coe kubernetes --docker-volume-size 3
fi

if ! openstack coe cluster list | grep -q "$os_magnum_cluster"; then
    openstack coe cluster create "$os_magnum_cluster" \
        --cluster-template "$os_magnum_template" \
        --master-count 1 \
        --node-count 1 \
        --keypair mykey
fi

mkdir -p ~/clusters/kubernetes-cluster
#$(openstack coe cluster config kubernetes-cluster --dir ~/clusters/kubernetes-cluster)
#export KUBECONFIG=/home/user/clusters/kubernetes-cluster/config
#kubectl -n kube-system get po
