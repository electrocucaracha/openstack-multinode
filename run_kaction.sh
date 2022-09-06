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
    set -o xtrace
fi

# NOTE: PYTHONPATH helps to pass the kolla_ansible module verification using Ansible's python
PYTHONPATH="$(python -c 'import sys; print(":".join(sys.path))')"
export PYTHONPATH

if [[ ${OS_DEBUG:-false} == "true" ]]; then
    kolla-ansible \
        -e "ansible_user=$USER" \
        -e 'ansible_become=true' \
        -e 'ansible_become_method=sudo' \
        --verbose \
        "$1" \
        -i "${OS_INVENTORY_FILE:-./samples/aio/hosts.ini}" \
        --yes-i-really-really-mean-it
else
    kolla-ansible \
        -e "ansible_user=$USER" \
        -e 'ansible_become=true' \
        -e 'ansible_become_method=sudo' \
        "$1" \
        -i "${OS_INVENTORY_FILE:-./samples/aio/hosts.ini}" \
        --yes-i-really-really-mean-it
fi
