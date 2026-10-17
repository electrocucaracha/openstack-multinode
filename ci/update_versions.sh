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

trap "make fmt" EXIT

if ! command -v uvx >/dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi
uvx pre-commit autoupdate
uv run --no-project --with git+https://github.com/electrocucaracha/gh-updater.git gh-updater .
