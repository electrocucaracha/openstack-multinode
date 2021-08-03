#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2021
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

set -o errexit
set -o pipefail
if [[ "${OS_DEBUG:-false}" == "true" ]]; then
    set -o xtrace
fi

function get_github_latest_tag {
    version=""
    attempt_counter=0
    max_attempts=5

    until [ "$version" ]; do
        tags="$(curl -s "https://api.github.com/repos/$1/tags")"
        if [ "$tags" ]; then
            version="$(echo "$tags" | grep -Po '"name":.*?[^\\]",' | awk -F  "\"" 'NR==1{print $4}')"
            break
        elif [ ${attempt_counter} -eq ${max_attempts} ];then
            echo "Max attempts reached"
            exit 1
        fi
        attempt_counter=$((attempt_counter+1))
        sleep $((attempt_counter*2))
    done

    echo "${version#*v}"
}

robox_latest_version="$(get_github_latest_tag lavabit/robox)"
cat << EOT > distros_supported.yml
---
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2019
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

centos:
  8:
    name: generic/centos8
    version: $robox_latest_version
    vb_controller: IDE Controller
ubuntu:
  focal:
    name: generic/ubuntu2004
    vb_controller: IDE Controller
    version: $robox_latest_version
debian:
  buster:
    name: generic/debian10
    vb_controller: IDE Controller
    version: $robox_latest_version
rhel:
  8:
    name: generic/rhel8
    vb_controller: IDE Controller
    version: $robox_latest_version
EOT
