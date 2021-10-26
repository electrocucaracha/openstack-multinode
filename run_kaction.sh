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
if [[ "${OS_DEBUG:-false}" == "true" ]]; then
    set -o xtrace
fi
set -o xtrace

# NOTE: PYTHONPATH helps to pass the kolla_ansible module verification using Ansible's python
PYTHONPATH="$(python -c 'import sys; print(":".join(sys.path))')"
export PYTHONPATH

kolla-ansible \
    -e "ansible_user=root" \
    -e "ansible_python_interpreter=$(command -v python)" \
    -e 'ansible_become=true' \
    -e 'ansible_become_method=sudo' \
    "$1" \
    -i "${OS_INVENTORY_FILE:-./samples/aio/hosts.ini}" \
    --yes-i-really-really-mean-it
