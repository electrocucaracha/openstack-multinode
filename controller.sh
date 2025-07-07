#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2018
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

_start=$(date +%s)
trap 'printf "Controller installation process: %s secs\n" "$(($(date +%s)-_start))"' EXIT

# NOTE: Required for HA setups to allow rabbit hostname resolves uniquely to the proper IP address
echo "" | sudo tee /etc/hosts
