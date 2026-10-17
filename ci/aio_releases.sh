#!/bin/bash
# SPDX-license-identifier: Apache-2.0

function get_release {
    local distro=${1:-$OS_DISTRO}
    local release_pointer=${CI_INITIAL_RELEASE_POINTER:-3}

    while ((release_pointer >= 1)); do
        local release
        release=$(sed -n "${release_pointer}p" releases.txt)

        if [[ -f "./requirements/${release}/${distro}.txt" ]]; then
            printf '%s\n' "$release"
            return
        fi

        release_pointer=$((release_pointer - 1))
    done
}

function get_aio_matrix {
    local distro
    while read -r distro; do
        if [[ -n $distro && -n $(get_release "$distro") ]]; then
            printf '%s\n' "$distro"
        fi
    done | jq -cnR '[inputs | select(length > 0)]' |
        jq -ce 'if length > 0 then . else error("No supported AIO distro/release combinations") end'
}
