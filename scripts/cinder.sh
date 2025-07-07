#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2024
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

os_cinder_volume_type="lvm-1"

if ! openstack volume type list | grep -q "$os_cinder_volume_type"; then
	openstack volume type create "$os_cinder_volume_type" \
		--property volume_backend_name="$os_cinder_volume_type"
fi
