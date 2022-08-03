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
if [[ "${OS_DEBUG:-false}" == "true" ]]; then
    export PKG_DEBUG=true
    set -o xtrace
fi

function set_values {
    for env_var in $(printenv | grep "OS_KOLLA_"); do
        sudo --preserve-env="${env_var%=*}" "$(command -v yq)" e -i \
        ".$(echo "${env_var%=*}" |  tr '[:upper:]' '[:lower:]' | sed 's/os_kolla_//g') = strenv(${env_var%=*})" \
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
