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
EXTRA_OPTS="--extra ansible_user=$USER --extra ansible_become=true --extra ansible_become_method=sudo"
export PYTHONPATH EXTRA_OPTS

ansible_cmd="kolla-ansible $1 --inventory ${OS_INVENTORY_FILE:-./samples/aio/hosts.ini}"
if [[ ${OS_DEBUG:-false} == "true" ]]; then
    ansible_cmd+=" --verbose"
fi
if [[ $1 == "destroy" ]]; then
    ansible_cmd+=" --yes-i-really-really-mean-it"
fi
$ansible_cmd
