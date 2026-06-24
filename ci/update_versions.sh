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

gh_actions=$(grep -rhoE 'uses: [^@]+@' .github |
    sed -E 's/uses: ([^@]+)@/\1/' |
    sort -u)

readonly exceptions=(
    'reviewdog/action-misspell'
    'actions/attest-build-provenance'
    'GrantBirki/git-diff-action'
    'golangci/golangci-lint-action'
    'actions/checkout'
    'actions/upload-artifact'
    'tcort/github-action-markdown-link-check'
)

readonly pinned_actions=()

for action in $gh_actions; do
    is_pinned=false
    for pinned in "${pinned_actions[@]}"; do
        if [[ $action == "$pinned" ]]; then
            is_pinned=true
            break
        fi
    done

    if [[ $is_pinned == true ]]; then
        echo "Skipping auto-update for pinned action: $action"
        continue
    fi

    is_exception=false
    for ex in "${exceptions[@]}"; do
        if [[ $action == "$ex" ]]; then
            is_exception=true
            break
        fi
    done

    if [[ $is_exception == true ]]; then
        continue
    fi

    commit_hash=$(
        git ls-remote --tags "https://github.com/$action" |
            awk '
        {
            sha=$1
            ref=$2

            if (ref ~ /\^\{\}$/) {
                tag=ref
                sub(/\^\{\}$/, "", tag)
                commits[tag]=sha
            } else {
                tags[ref]=sha
            }
        }
        END {
            for (ref in tags) {
                sha = (ref in commits ? commits[ref] : tags[ref])

                tag = ref
                sub(/^refs\/tags\//, "", tag)

                # semver only
                if (tag ~ /^v?[0-9]+(\.[0-9]+)*$/) {
                    sortkey = tag
                    sub(/^v/, "", sortkey)
                    print sortkey "\t" sha "\t" tag
                }
            }
        }' |
            sort -V |
            tail -1 |
            awk -F'\t' '{ printf "%s # %s\n", $2, $3 }'
    )

    if [[ -z $commit_hash ]]; then
        echo "WARNING: unable to resolve tag for $action; skipping" >&2
        continue
    fi

    while IFS= read -r -d '' file; do
        sed -i -e "s|uses: $action@.*|uses: $action@$commit_hash|g" "$file"
    done < <(grep -ElRZ "uses: $action@" .github/)
done
