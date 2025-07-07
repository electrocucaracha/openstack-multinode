#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2020,2023
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

function _get_kolla_ansible_cmd {
	local kolla_action=$1

	cmd="$(command -v kolla-ansible || echo kolla-ansible) $kolla_action --inventory ${OS_INVENTORY_FILE:-./samples/aio/hosts.ini}"
	if [[ ${OS_DEBUG:-false} == "true" ]]; then
		cmd+=" --verbose"
	fi
	if [[ $1 == "destroy" ]]; then
		cmd+=" --yes-i-really-really-mean-it"
	fi

	echo "$cmd"
}

if [[ ${__name__:-"__main__"} == "__main__" ]]; then
	ansible_cmd=$(_get_kolla_ansible_cmd "$1")
	$ansible_cmd
fi
