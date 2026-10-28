---
title: Install and use OpenStack Multi-Node
---

# Install and use OpenStack Multi-Node

This guide helps you choose a deployment method and get an OpenStack
development or test environment running.
Choose a Vagrant sample to isolate the deployment from your host, or use the
direct installer on a dedicated Linux machine.

These environments are not production reference architectures.
For topology-specific resource requirements and details, see the
[all-in-one](sample-aio.html), [no-HA](sample-noha.html), and
[distributed](sample-distributed.html) guides.

## Choose a deployment method

| Method | Use it when | Start here |
| --- | --- | --- |
| All-in-one Vagrant | You want a single VM for a small development or test cloud. | [All-in-one sample](sample-aio.html) |
| No-HA Vagrant | You want a controller and compute nodes. | [No-HA sample](sample-noha.html) |
| Distributed Vagrant | You want separate service VMs and a dedicated deployment host. | [Distributed sample](sample-distributed.html) |
| Direct installer | You have a dedicated, supported Linux host and want to install on it. | [Install directly](#install-on-a-dedicated-linux-host) |

## Run a Vagrant sample

Install Vagrant and either VirtualBox or libvirt, including the provider
plugins and host packages required by your platform.
The sample Vagrantfiles define their VM resources and network topology.

From the repository root, choose one sample:

```bash
# One VM with the OpenStack services.
cd samples/aio
vagrant up
```

```bash
# Compute nodes first, then the controller.
cd samples/noha
VAGRANT_EXPERIMENTAL=disks vagrant up
vagrant up controller
```

```bash
# Start the service VMs, then the separate deployment host.
cd samples/distributed
vagrant up
vagrant up undercloud
```

The no-HA sample defaults to two compute nodes.
Set `OS_NUM_COMPUTE_NODES` before `vagrant up` to change the count.
The all-in-one and no-HA samples accept `CPU` and `MEMORY` to change their
default VM resources.
The sample guides describe other settings and provide the topology diagrams.

## Install on a dedicated Linux host

The direct installer changes host packages and system configuration.
Use a dedicated, supported Linux host with passwordless `sudo`;
do not run it on a workstation or a host with workloads you need to keep.

The management interface must have an IPv4 address.
The Neutron external interface must be a different, dedicated interface with
no host IP address.
Review the [networking reference](neutron-network-types.html) and the
[Kolla-Ansible quick start](https://docs.openstack.org/kolla-ansible/latest/user/quickstart.html)
before deployment.

From the repository root, replace `eno1` and `eno2` with the correct interface
names for your host:

```bash
OS_FOLDER="$PWD" \
  OS_KOLLA_NETWORK_INTERFACE=eno1 \
  OS_KOLLA_NEUTRON_EXTERNAL_INTERFACE=eno2 \
  bash ./install.sh
```

If you do not have a checkout, download and review the installer before
running it:

```bash
curl -fsSL https://raw.githubusercontent.com/electrocucaracha/openstack-multinode/master/install.sh -o install-openstack.sh
less install-openstack.sh
OS_KOLLA_NETWORK_INTERFACE=eno1 \
  OS_KOLLA_NEUTRON_EXTERNAL_INTERFACE=eno2 \
  bash ./install-openstack.sh
```

Without `OS_FOLDER`, the installer clones the repository to
`/opt/openstack-multinode`.

## Use the deployed cloud

The installer generates Kolla credentials in `/etc/kolla` and runs the
Kolla-Ansible deployment actions.
With the default `OS_KOLLA_RUN_INIT=true`, it also installs the OpenStack
client, runs Kolla-Ansible's `init-runonce` example setup, and applies the
enabled project-specific initialization scripts.

After deployment, load the generated administrator credentials in your
current shell and check that the cloud responds:

```bash
source /etc/kolla/admin-openrc.sh
openstack token issue
```

To skip the example cloud initialization, set `OS_KOLLA_RUN_INIT=false`
before running the installer.
This also skips the OpenStack client and the project's optional initialization
scripts.

## Upgrade an environment

Before upgrading, review the OpenStack and Kolla-Ansible upgrade guidance and
confirm that this repository includes a requirements file for the target
release and your host distribution.
From the deployment host, run `upgrade.sh` with the target release:

```bash
OPENSTACK_RELEASE=2025.2 ./upgrade.sh
```

The script updates the deployment host's Python requirements and runs the
Kolla-Ansible `pull` and `upgrade` actions.
It does not replace release-specific preparation, backup, or recovery
planning.
See the [release history](https://github.com/electrocucaracha/openstack-multinode/blob/master/CHANGELOG.md)
and the upstream [Kolla-Ansible documentation](https://docs.openstack.org/kolla-ansible/latest/).

## Common settings

Set environment variables before starting the installer or Vagrant sample.
The defaults below come from `defaults.env` and the installer; a sample can
override them.

| Variable | Default | Purpose |
| --- | --- | --- |
| `OPENSTACK_RELEASE` | `2025.1` | Selects the OpenStack release and matching Python requirements. |
| `OS_KOLLA_DEPLOY_PROFILE` | `complete` | Selects the Kolla-Ansible deployment action profile. |
| `OS_ENABLE_LOCAL_REGISTRY` | `false` | Builds or prepares images using a local registry when enabled. |
| `OS_KOLLA_NETWORK_INTERFACE` | Detected from the default route | Selects the management interface. Set it explicitly if route detection is not appropriate. |
| `OS_KOLLA_NEUTRON_EXTERNAL_INTERFACE` | Detected only for a matching route; otherwise required | Selects the dedicated Neutron external interface. |
| `OS_KOLLA_RUN_INIT` | `true` | Controls the post-deployment example setup and project initialization scripts. |
| `OS_INVENTORY_FILE` | `./samples/aio/hosts.ini` | Selects the Ansible inventory used by the deployment host. |
| `OS_DEBUG` | `false` | Enables shell tracing and additional diagnostic output when set to `true`. |

The `OS_KOLLA_` variables are translated to matching lowercase settings in
`/etc/kolla/globals.yml`.
For example, `OS_KOLLA_ENABLE_HORIZON=yes` sets the Kolla `enable_horizon`
setting.
See [how the deployment works](architecture.html) for the configuration flow.

## Next steps

- [Understand the deployment architecture](architecture.html).
- [Extend a deployment](extending.html).
- [Configure Neutron network types](neutron-network-types.html).
- Use the upstream [Kolla-Ansible documentation](https://docs.openstack.org/kolla-ansible/latest/)
  for Kolla-specific configuration and operations.
