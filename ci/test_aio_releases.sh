#!/bin/bash
# SPDX-license-identifier: Apache-2.0

set -o errexit
set -o pipefail

cd "$(dirname "$0")/.."
source ./ci/aio_releases.sh

export CI_INITIAL_RELEASE_POINTER=3
[[ $(get_release ubuntu_24) == "2025.1" ]]
[[ $(get_release debian_12) == "2025.1" ]]
[[ -z $(get_release ubuntu_26) ]]
[[ -z $(get_release debian_11) ]]
[[ $(printf '%s\n' ubuntu_24 ubuntu_26 debian_11 debian_12 | get_aio_matrix) == '["ubuntu_24","debian_12"]' ]]

export CI_INITIAL_RELEASE_POINTER=1
[[ $(get_release ubuntu_24) == "2026.1" ]]
[[ -z $(get_release debian_12) ]]
[[ $(printf '%s\n' ubuntu_24 ubuntu_26 debian_11 debian_12 | get_aio_matrix) == '["ubuntu_24"]' ]]
if printf '%s\n' ubuntu_26 debian_11 | get_aio_matrix; then
    echo "An unsupported-only matrix must fail" >&2
    exit 1
fi
if OS_DISTRO=ubuntu_26 bash ./ci/check_aio.sh; then
    echo "An unsupported AIO deployment must fail" >&2
    exit 1
fi

echo "AIO release selection tests passed"
