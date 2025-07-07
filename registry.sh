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
trap 'printf "Registry creation process: %s secs\n" "$(($(date +%s)-_start))"' EXIT

# NOTE: Shorten link -> https://github.com/electrocucaracha/pkg-mgr_scripts
curl -fsSL http://bit.ly/install_pkg | PKG_COMMANDS_LIST="skopeo,docker,jq,git,crudini" bash

if ! command -v uv; then
	curl -LsSf https://astral.sh/uv/install.sh | sh
	PATH="$HOME/.local/bin:$PATH"
fi

if ! command -v kolla-build; then
	sudo "$(command -v uv)" pip install "git+https://github.com/openstack/kolla.git@${OS_KOLLA_VERSION:-stable/2024.2}" --system
	sudo "$(command -v uv)" pip install docker-squash --system
fi

# Start local registry
if [[ -z $(sudo docker ps -aqf "name=registry") ]]; then
	sudo -E docker run -d --name registry --restart=always \
		-p "${DOCKER_REGISTRY_PORT:-5000}":5000 -v registry:/var/lib/registry registry:2
fi

# Configure custom values
sudo mkdir -p /etc/kolla
sudo cp ./etc/kolla/kolla-build.ini /etc/kolla/kolla-build.ini
# shellcheck disable=SC1091
source /etc/os-release || source /usr/lib/os-release
num_cpus=$(lscpu | grep "^CPU(s):" | awk '{ print $2 }')

for kv in "tag=${OPENSTACK_TAG:-"2024.2-${ID,,}-${VERSION_CODENAME:-${VERSION_ID%%.*}}"}" \
	"profile=${OS_KOLLA_PROFILE:-custom}" \
	"registry=${DOCKER_REGISTRY_IP:-127.0.0.1}:${DOCKER_REGISTRY_PORT:-5000}" \
	"openstack_release=${OPENSTACK_RELEASE:-2024.2}" \
	"base=${OS_KOLLA_BASE:-${ID,,}}" \
	"threads=$((num_cpus * 2))" \
	"push_threads=$((num_cpus * 4))"; do
	sudo -E "$(command -v crudini)" --set /etc/kolla/kolla-build.ini DEFAULT "${kv%=*}" "${kv#*=}"
done

bifrost_header=""
bifrost_footer=""
if [ -n "${HTTP_PROXY-}" ]; then
	bifrost_header+="ENV http_proxy=$HTTP_PROXY\n"
	bifrost_footer+="ENV http_proxy=\"\"\n"
fi
if [ -n "${HTTPS_PROXY-}" ]; then
	bifrost_header+="ENV https_proxy=$HTTPS_PROXY\n"
	bifrost_footer+="ENV https_proxy=\"\"\n"
fi
if [ -n "${NO_PROXY-}" ]; then
	bifrost_header+="ENV no_proxy=$NO_PROXY\n"
	bifrost_footer+="ENV no_proxy=\"\"\n"
fi

cat <<EOL >"$HOME/template-overrides.j2"
{% extends parent_template %}

{% block bifrost_base_header %}
$bifrost_header
{% endblock %}

{% block bifrost_base_footer %}
$bifrost_footer
{% endblock %}
EOL
#sudo kolla-build --type source --template-override $HOME/template-overrides.j2 bifrost-deploy

# Kolla Docker images creation
kolla_cmd="kolla-build ${OS_KOLLA_BUILD_ARGS:-"--config-file /etc/kolla/kolla-build.ini"}"
newgrp docker <<EONG
# PEP 370 -- Per user site-packages directory
[[ "$PATH" != *.local/bin* ]] && export PATH=$PATH:$HOME/.local/bin

SNAP=$HOME/.local/ $kolla_cmd | jq "." | tee "$HOME/output.json"
EONG
if [[ $(jq '.failed | length ' "$HOME/output.json") != 0 ]]; then
	for image in $(jq -r '.failed[].name' "$HOME/output.json"); do
		image_name="$image:${OPENSTACK_TAG:-"2024.2-${ID,,}-${VERSION_CODENAME:-${VERSION_ID%%.*}}"}"
		if [ "$(curl "http://localhost:5000/v2/kolla/${image_name%:*}/tags/list" -o /dev/null -w '%{http_code}\n' -s)" != "200" ] || [ "$(curl "http://localhost:5000/v2/kolla/${image_name%:*}/manifests/${image_name#*:}" -o /dev/null -w '%{http_code}\n' -s)" != "200" ]; then
			local_img_name="${DOCKER_REGISTRY_IP:-127.0.0.1}:${DOCKER_REGISTRY_PORT:-5000}/kolla/$image_name"
			remote_img_name="quay.io/openstack.kolla/$image_name"
			if command -v skopeo; then
				skopeo copy --dest-tls-verify=false "docker://$remote_img_name" "docker://$local_img_name"
			else
				docker pull "quay.io/openstack.kolla/$image_name"
				docker tag "quay.io/openstack.kolla/$image_name" "$local_img_name"
				docker push "$local_img_name"
			fi
		fi
	done
fi
