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
set -o xtrace

# shellcheck disable=SC1091
source /etc/os-release || source /usr/lib/os-release
case ${ID,,} in
    rhel|centos|fedora)
        eval "sudo -H -E $(command -v dnf || command -v yum) -y install libvirt-client"
    ;;
esac
