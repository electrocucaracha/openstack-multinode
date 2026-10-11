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

resolve_action_commit_hash() {
    local action=$1
    local version_pattern=$2

    git ls-remote --tags "https://github.com/$action" |
        awk -v version_pattern="$version_pattern" '
        {
            sha=$1
            tag=$2
            deref = (tag ~ /\^\{\}$/) ? 1 : 0

            sub(/^refs\/tags\//, "", tag)
            sub(/\^\{\}$/, "", tag)

            if (tag ~ version_pattern) {
                sortkey=tag
                sub(/^[vV]/, "", sortkey)

                print sortkey "\t" deref "\t" sha "\t" tag
            }
        }' |
        sort -V -k1,1 -k2,2n |
        tail -1 |
        awk -F'\t' '{ printf "%s # %s\n", $3, $4 }'
}

resolve_reusable_workflow_commit_hash() {
    local workflow=$1
    local ref=$2
    local repo=${workflow%%/.github/workflows/*}
    local commit_hash

    # A full SHA is already immutable; no lookup required.
    if [[ $ref =~ ^[0-9a-fA-F]{40}$ ]]; then
        printf "%s # %s\n" "$ref" "$ref"
        return
    fi

    # For version-like refs, resolve the latest matching tag.
    commit_hash=$(resolve_action_commit_hash "$repo" '^[vV]?[0-9]+(\.[0-9]+)*$')
    if [[ -n $commit_hash ]]; then
        printf "%s\n" "$commit_hash"
        return
    fi

    # Otherwise resolve the ref directly as a branch or tag.
    git ls-remote \
        "https://github.com/$repo" \
        "refs/heads/$ref" \
        "refs/tags/$ref" \
        "refs/tags/$ref^{}" |
        awk -v ref="$ref" '
        {
            sha=$1
            target=$2
            deref = (target ~ /\^\{\}$/) ? 1 : 0

            if (target ~ /^refs\/heads\// || deref || best == "") {
                best=sha
            }
        }

        END {
            if (best == "") {
                exit 1
            }

            printf "%s # %s\n", best, ref
        }'
}

resolve_reusable_workflow_ref() {
    local workflow=$1

    grep -rhoE "uses: $workflow@[^[:space:]]+( # [^[:space:]]+)?" .github |
        awk '
    {
        sub(/^.*@/, "")
        if ($2 == "#" && $3 != "") {
            print $3
        } else {
            print $1
        }
    }' |
        sort -u |
        tail -1
}

# Update GitHub Action commit hashes
gh_actions=$(grep -rhoE 'uses: [^@]+@' .github | sed -E 's/uses: ([^@]+)@/\1/' | sort -u)
exceptions=('reviewdog/action-misspell' 'actions/attest-build-provenance' 'GrantBirki/git-diff-action' 'golangci/golangci-lint-action' 'actions/checkout' 'actions/upload-artifact')
# Actions pinned to a specific version and excluded from auto-updates.
# Remove an entry only once the underlying issue is confirmed resolved.
# austenstone/copilot-cli: v3.0+ depends on actions/setup-copilot@v0 which does
# not yet exist publicly; keep at v2.0 until that action is released.
readonly pinned_actions=('austenstone/copilot-cli')
for action in $gh_actions; do
    is_pinned=false
    for pinned in "${pinned_actions[@]}"; do
        if [[ $action == "$pinned" ]]; then
            is_pinned=true
            break
        fi
    done
    if [[ $is_pinned == "true" ]]; then
        echo "Skipping auto-update for pinned action: $action"
        continue
    fi
    if [[ $action == */.github/workflows/*.yml ]]; then
        ref=$(resolve_reusable_workflow_ref "$action")
        commit_hash=$(resolve_reusable_workflow_commit_hash "$action" "$ref")
    elif [[ ${exceptions[*]} =~ (^|[^[:alpha:]])$action([^[:alpha:]]|$) ]]; then
        commit_hash=$(resolve_action_commit_hash "$action" '^v?[0-9]+(\.[0-9]+)*$')
    else
        commit_hash=$(resolve_action_commit_hash "$action" '^[vV]?[0-9]+(\.[0-9]+)*$')
    fi
    grep -ElRZ "uses: $action@" .github/ | xargs -0 -L 1 sed -i -e "s|uses: $action@.*|uses: $action@$commit_hash|g"
done
