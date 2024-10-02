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
if [[ ${OS_DEBUG:-false} == "true" ]]; then
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
            elif [ ${attempt_counter} -eq ${max_attempts} ]; then
                echo "Max attempts reached"
                exit 1
            fi
            attempt_counter=$((attempt_counter + 1))
            sleep $((attempt_counter * 2))
        done
    fi

    echo "${version#*v}"
}

function _vagrant_pull {
    local alias="$1"
    local name="$2"
    local project_id="$3"
    local family="$4"
    local vb_controller="${5:-IDE Controller}"

    version=$(_get_box_current_version "$name")

    if [ "$(curl "https://app.vagrantup.com/${name%/*}/boxes/${name#*/}/versions/$version/providers/$PROVIDER.box" -o /dev/null -w '%{http_code}\n' -s)" == "302" ] && [ "$(vagrant box list | grep -c "$name .*$PROVIDER, $version")" != "1" ]; then
        vagrant box remove --provider "$PROVIDER" --all --force "$name" || :
        vagrant box add --provider "$PROVIDER" --box-version "$version" "$name"
    elif [ "$(vagrant box list | grep -c "$name .*$PROVIDER, $version")" == "1" ]; then
        echo "$name($version, $PROVIDER) box is already present in the host"
    else
        msg+="$name($version, $PROVIDER) box doesn't exist\n"
        return
    fi
    # editorconfig-checker-disable
    # prettier-ignore-start
    cat <<EOT >>.distros_supported.yml
$alias:
  name: $name
  vb_controller: $vb_controller
  version: "$version"
  project_id: $project_id
  family: $family
EOT
    # prettier-ignore-end
    # editorconfig-checker-enable
}

if ! command -v vagrant >/dev/null; then
    # NOTE: Shorten link -> https://raw.githubusercontent.com/electrocucaracha/pkg-mgr_scripts/master/install.sh
    curl -fsSL http://bit.ly/install_pkg | PKG=vagrant bash
fi

cat <<EOT >.distros_supported.yml
---
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2019 - $(date '+%Y')
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################
EOT

_vagrant_pull "rocky_9" "rockylinux/9" "rocky-linux-cloud" "rocky-linux-9"
_vagrant_pull "ubuntu_22" "generic/ubuntu2204" "ubuntu-os-cloud" "ubuntu-2204-lts"
_vagrant_pull "debian_11" "debian/bullseye64" "debian-cloud" "debian-11" "SATA Controller"

if [ "$msg" ]; then
    echo -e "$msg"
    rm .distros_supported.yml
else
    mv .distros_supported.yml distros_supported.yml
fi
