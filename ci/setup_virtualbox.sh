#!/bin/bash
# SPDX-license-identifier: Apache-2.0

set -o errexit
set -o pipefail

if ! sudo modprobe vboxdrv; then
    echo "::notice::Rebuilding VirtualBox modules for kernel $(uname -r)"
    sudo apt-get update
    sudo apt-get install -y --no-install-recommends \
        build-essential dkms "linux-headers-$(uname -r)"
    if command -v /sbin/vboxconfig >/dev/null; then
        sudo /sbin/vboxconfig
    else
        sudo dkms autoinstall -k "$(uname -r)"
    fi
    if ! sudo modprobe vboxdrv; then
        echo "::error::Cannot load vboxdrv after rebuilding; check kernel logs for compatibility or Secure Boot signature errors." >&2
        exit 1
    fi
fi
