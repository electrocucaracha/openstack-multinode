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

PROVIDER=${PROVIDER:-virtualbox}
msg=""

function _get_box_current_version {
    version=""
    attempt_counter=0
    max_attempts=5
    name="$1"

    if [ -f ./ci/pinned_vagrant_boxes.txt ] && grep -q "^${name} .*$PROVIDER" ./ci/pinned_vagrant_boxes.txt; then
        version=$(grep "^${name} .*$PROVIDER" ./ci/pinned_vagrant_boxes.txt | awk '{ print $2 }')
    else
        until [ "$version" ]; do
            metadata="$(curl -s "https://app.vagrantup.com/api/v1/box/$name")"
            if [ "$metadata" ]; then
                version="$(echo "$metadata" | python -c 'import json,sys;print(json.load(sys.stdin)["current_version"]["version"])')"
                break
            elif [ ${attempt_counter} -eq ${max_attempts} ];then
                echo "Max attempts reached"
                exit 1
            fi
            attempt_counter=$((attempt_counter+1))
            sleep $((attempt_counter*2))
        done
    fi

    echo "${version#*v}"
}

function _vagrant_pull {
    local alias="$1"
    local name="$2"

    version=$(_get_box_current_version "$name")

    if [ "$(curl "https://app.vagrantup.com/${name%/*}/boxes/${name#*/}/versions/$version/providers/$PROVIDER.box" -o /dev/null -w '%{http_code}\n' -s)" == "302" ] && [ "$(vagrant box list | grep -c "$name .*$PROVIDER, $version")" != "1" ]; then
        vagrant box remove --provider "$PROVIDER" --all --force "$name" ||:
        vagrant box add --provider "$PROVIDER" --box-version "$version" "$name"
    elif [ "$(vagrant box list | grep -c "$name .*$PROVIDER, $version")" == "1" ]; then
        echo "$name($version, $PROVIDER) box is already present in the host"
    else
        msg+="$name($version, $PROVIDER) box doesn't exist\n"
        return
    fi
    cat << EOT >> .distros_supported.yml
  $alias:
    name: $name
    vb_controller: IDE Controller
    version: "$version"
EOT
}

if ! command -v vagrant > /dev/null; then
    # NOTE: Shorten link -> https://github.com/electrocucaracha/bootstrap-vagrant
    curl -fsSL http://bit.ly/initVagrant | bash
fi

cat << EOT > .distros_supported.yml
---
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2019
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

EOT

echo "centos:" >> .distros_supported.yml
_vagrant_pull "8" "centos/stream8"
echo "ubuntu:" >> .distros_supported.yml
_vagrant_pull "focal" "generic/ubuntu2004"
echo "debian:" >> .distros_supported.yml
_vagrant_pull "buster" "generic/debian10"

if [ "$msg" ]; then
    echo -e "$msg"
    rm .distros_supported.yml
else
    mv .distros_supported.yml distros_supported.yml
fi
