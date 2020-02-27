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

SNAP=$HOME/.local/ kolla-ansible -vvv \
    -e "ansible_user=${OS_KOLLA_USER:-kolla}" \
    -e 'ansible_become=true' -e 'ansible_become_method=sudo' "$1" \
    -i "${OS_INVENTORY_FILE:-./inventory/hosts.ini}" \
    --yes-i-really-really-mean-it
