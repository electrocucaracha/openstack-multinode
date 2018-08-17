#!/bin/bash
# SPDX-license-identifier: Apache-2.0
##############################################################################
# Copyright (c) 2018
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################

function install_docker {
    local max_concurrent_downloads=${1:-3}

    if $(docker version &>/dev/null); then
        return
    fi
    apt-get install -y software-properties-common linux-image-extra-$(uname -r) linux-image-extra-virtual apt-transport-https ca-certificates curl
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce

    mkdir -p /etc/systemd/system/docker.service.d
    cat <<EOL > /etc/systemd/system/docker.service.d/kolla.conf
[Service]
MountFlags=shared
EOL
    if [ $http_proxy ]; then
        cat <<EOL > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=$http_proxy"
EOL
    fi
    if [ $https_proxy ]; then
        cat <<EOL > /etc/systemd/system/docker.service.d/https-proxy.conf
[Service]
Environment="HTTPS_PROXY=$https_proxy"
EOL
    fi
    if [ $no_proxy ]; then
        cat <<EOL > /etc/systemd/system/docker.service.d/no-proxy.conf
[Service]
Environment="NO_PROXY=$no_proxy"
EOL
    fi
    systemctl daemon-reload
    echo "DOCKER_OPTS=\"-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --max-concurrent-downloads $max_concurrent_downloads \"" >> /etc/default/docker
    usermod -aG docker $USER

    systemctl restart docker
    sleep 10
}

install_docker
apt install -y python2.7 python-dev build-essential sshpass

curl -sL https://bootstrap.pypa.io/get-pip.py | sudo python

for repo in kolla kolla-ansible; do
    git clone https://github.com/openstack/$repo
    pushd $repo
    pip install .
    popd
done

mkdir -p /etc/ansible/
cat << EOLF > /etc/ansible/ansible.cfg
[defaults]
host_key_checking = false
EOLF

kolla-build --config-file /etc/kolla/kolla-build.conf
kolla-genpwd
kolla-ansible -vvv deploy -i /vagrant/inventory/hosts.ini | tee openstack-deployment.log
kolla-ansible post-deploy -i /vagrant/inventory/hosts.ini
pip install python-openstackclient
echo "source /etc/kolla/admin-openrc.sh" >> .profile
