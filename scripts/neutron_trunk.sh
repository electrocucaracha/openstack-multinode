#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2021
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

net_prefix=demo-net
subnet_prefix=demo-subnet
port_prefix=demo-port

# PEP 370 -- Per user site-packages directory
[[ $PATH != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin

if ! command -v neutron >/dev/null; then
    pip install python-neutronclient
fi

# Create networks and subnets for the trunk and subports
for i in $(seq 1 5); do
    if ! openstack network list -c Name | grep -q "$net_prefix$i"; then
        openstack network create "$net_prefix$i"
    fi
    if ! openstack subnet list -c Name | grep -q "$subnet_prefix$i"; then
        openstack subnet create --network "$net_prefix$i" --subnet-range "10.0.$i.0/24" "$subnet_prefix$i"
    fi
    if ! openstack port list -c name | grep -q "$port_prefix$i"; then
        openstack port create --network "$net_prefix$i" "$port_prefix$i"
    fi
done

if ! openstack port list -c name | grep -q "trunk-parent"; then
    openstack port create --network demo-net trunk-parent
fi

# Create the trunk and add subports to the trunk
if ! openstack network trunk list -c Name | grep -q "trunk1"; then
    openstack network trunk create --parent-port trunk-parent trunk1
fi
for i in $(seq 1 5); do
    openstack network trunk set \
        --subport port="$port_prefix$i,segmentation-type=vlan,segmentation-id=$i" \
        trunk1
done
openstack network trunk show trunk1

if ! openstack server list -c Name | grep -q "demo1"; then
    openstack server create --image cirros --flavor m1.tiny \
        --key-name mykey --port trunk-parent --use-config-drive \
        demo1
fi
