#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2022
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

function setup_ansible {
    # Setup Mitogen
    mitogen_ansible_cfg=""
    if pip freeze | grep -q mitogen; then
        mitogen_ansible_cfg="
strategy = mitogen_linear
strategy_plugins = $(dirname "$(sudo find / -name mitogen_linear.py | head -n 1)")

"
    fi

    sudo tee /etc/ansible/ansible.cfg <<EOL
[defaults]
host_key_checking=False
remote_tmp=/tmp/
callbacks_enabled = timer, profile_tasks
$mitogen_ansible_cfg
[ssh_connection]
pipelinig=True
ssh_args = -o ControlMaster=auto -o ControlPersist=30m -o ConnectionAttempts=100 -o UserKnownHostsFile=/dev/null
EOL
    if [[ ${OS_DEBUG:-false} == "true" ]]; then
        # NOTE: Uses the simplest UTF-8 locale
        export LC_ALL=C.UTF-8
        # Print out Ansible configuration
        ansible-config dump --only-changed
    fi
}

function set_values {
    for env_var in $(printenv | grep "OS_KOLLA_"); do
        sudo --preserve-env="${env_var%=*}" "$(command -v yq)" e -i \
            ".$(echo "${env_var%=*}" | tr '[:upper:]' '[:lower:]' | sed 's/os_kolla_//g') = strenv(${env_var%=*})" \
            /etc/kolla/globals.yml
    done
}

function vercmp {
    local v1=$1
    local op=$2
    local v2=$3
    local result

    # sort the two numbers with sort's "-V" argument.  Based on if v2
    # swapped places with v1, we can determine ordering.
    result=$(echo -e "$v1\n$v2" | sort -V | head -1)

    case $op in
    "==")
        [ "$v1" = "$v2" ]
        return
        ;;
    ">")
        [ "$v1" != "$v2" ] && [ "$result" = "$v2" ]
        return
        ;;
    "<")
        [ "$v1" != "$v2" ] && [ "$result" = "$v1" ]
        return
        ;;
    ">=")
        [ "$result" = "$v2" ]
        return
        ;;
    "<=")
        [ "$result" = "$v1" ]
        return
        ;;
    *)
        echo "unrecognised op: $op"
        exit 1
        ;;
    esac
}

function run_kolla_actions {
    for action in "$@"; do
        ./run_kaction.sh "$action" | tee "$HOME/$action.log"
        echo "Kolla Action statistics:"
        grep ': .* -* .*s$' "$HOME/$action.log" || :
    done
}
