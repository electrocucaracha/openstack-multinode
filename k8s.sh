#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2020
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

set -o errexit
set -o nounset
set -o pipefail

# PEP 370 -- Per user site-packages directory
[[ "$PATH" != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin

pip install python-magnumclient
wget https://download.fedoraproject.org/pub/alt/atomic/stable/Fedora-Atomic-27-20180419.0/CloudImages/x86_64/images/Fedora-Atomic-27-20180419.0.x86_64.qcow2

# shellcheck disable=SC1091
source /etc/kolla/admin-openrc.sh

openstack image create \
    --disk-format=qcow2 \
    --container-format=bare \
    --file=Fedora-Atomic-27-20180419.0.x86_64.qcow2\
    --property os_distro='fedora-atomic' \
    fedora-atomic-latest

openstack coe cluster template create kubernetes-cluster-template \
    --image fedora-atomic-latest \
    --external-network public1 \
    --dns-nameserver 8.8.8.8 \
    --master-flavor m1.small \
    --flavor m1.small \
    --coe kubernetes \
    --docker-volume-size 3

openstack coe cluster create kubernetes-cluster \
    --cluster-template kubernetes-cluster-template \
    --master-count 1 \
    --node-count 1 \
    --keypair mykey

mkdir -p ~/clusters/kubernetes-cluster
#$(openstack coe cluster config kubernetes-cluster --dir ~/clusters/kubernetes-cluster)
#export KUBECONFIG=/home/user/clusters/kubernetes-cluster/config
#kubectl -n kube-system get po
