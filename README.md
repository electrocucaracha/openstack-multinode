# OpenStack Multi-Node Deployment

<!-- markdown-link-check-disable-next-line -->

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![GitHub Super-Linter](https://github.com/electrocucaracha/openstack-multinode/workflows/Lint%20Code%20Base/badge.svg)](https://github.com/marketplace/actions/super-linter)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

<!-- markdown-link-check-disable-next-line -->

![visitors](https://visitor-badge.laobi.icu/badge?page_id=electrocucaracha.openstack-multinode)
[![Scc Code Badge](https://sloc.xyz/github/electrocucaracha/openstack-multinode?category=code)](https://github.com/boyter/scc/)
[![Scc COCOMO Badge](https://sloc.xyz/github/electrocucaracha/openstack-multinode?category=cocomo)](https://github.com/boyter/scc/)

This repository provides Vagrant-based environments and deployment scripts
for testing OpenStack with [Kolla-Ansible][1].
The examples cover a single-node deployment, a no-HA cluster, and a
distributed topology.
They are intended for development and testing, not as production reference
architectures.

## Why containerized OpenStack?

[Kolla](https://docs.openstack.org/kolla/latest/) provides container images for
OpenStack services, while Kolla-Ansible configures and deploys those services.
Container-based deployment offers several benefits:

- **Repeatable environments:** Reusing the same image versions keeps service
  binaries and dependencies consistent across deployments.
- **Faster provisioning:** Prebuilt images reduce the need to install service
  packages individually on each host.
- **Scaling:** Additional compute nodes can run the same service images,
  with host preparation and inventory changes managed through Kolla-Ansible.
- **Service selection:** Services can be enabled or disabled through
  Kolla-Ansible configuration rather than manually installing or removing
  their packages.
- **Image-based updates:** Service containers can be recreated with updated
  images. Previous images can help recovery, but database migrations and
  persistent data mean upgrades are not automatically atomic or reversible.
- **Service recovery:** Container restart policies can restart failed
  containers; they do not by themselves provide high availability or recovery
  from host failures.

Containers still depend on a supported host operating system, networking,
and persistent storage. Image portability does not remove those requirements.

## Deployment examples

- [All-in-one](docs/sample-aio.md): run the OpenStack services on one VM.
- [No high availability](docs/sample-noha.md): run a controller and compute
  nodes, using Vagrant or physical Raspberry Pi hardware.
- [Distributed](docs/sample-distributed.md): provision a multi-VM topology
  with separate controller, compute, storage, registry, and monitoring roles.

For prerequisites, setup guidance, and networking references, start at the
[documentation index](docs/index.md).

The deployment scripts prepare nodes, configure Kolla-Ansible, and optionally
build and publish container images to a local registry:

- [node.sh](node.sh) prepares hosts and can partition, format, and mount
  additional volumes. Only pass disposable disks to its volume options.
- [registry.sh](registry.sh) sets up the local container image registry.
- [undercloud.sh](undercloud.sh) configures and runs Kolla-Ansible. The
  distributed sample uses a separate undercloud VM to provision service nodes.
- [install.sh](install.sh) coordinates an all-in-one deployment, including
  optional registry setup and post-deployment initialization.

## Deploy all-in-one directly

The [all-in-one Vagrant guide](docs/sample-aio.md) provides the VM-based path.
You can also run the installer directly on a dedicated, supported Linux host
with passwordless sudo. This changes host packages and system configuration;
do not run it on your workstation or a host with workloads you need to keep.

From the repository root, replace `eno1` and `eno2` with your host's interfaces:

```bash
OS_FOLDER="$PWD" \
  OS_KOLLA_NETWORK_INTERFACE=eno1 \
  OS_KOLLA_NEUTRON_EXTERNAL_INTERFACE=eno2 \
  bash ./install.sh
```

The management interface must have an IPv4 address. The Neutron external
interface must be separate, dedicated to Neutron, and have no host IP address.
Review the [networking reference](docs/neutron-network-types.md) and
[upstream prerequisites](https://docs.openstack.org/kolla-ansible/latest/user/quickstart.html)
before deploying.

To bootstrap without an existing checkout, download and review the installer
before running it with the same interface settings:

```bash
curl -fsSL https://raw.githubusercontent.com/electrocucaracha/openstack-multinode/master/install.sh -o install-openstack.sh
less install-openstack.sh
OS_KOLLA_NETWORK_INTERFACE=eno1 \
  OS_KOLLA_NEUTRON_EXTERNAL_INTERFACE=eno2 \
  bash ./install-openstack.sh
```

In this case, the installer clones the repository into `/opt/openstack-multinode`
unless `OS_FOLDER` points to another location.

![Codebase structure](./codebase-structure.svg)

## Contributing

Contributions are welcome, including code, documentation, testing, and
community outreach.

![Contributors](https://contrib.rocks/image?repo=electrocucaracha/openstack-multinode)

[1]: https://docs.openstack.org/kolla-ansible/latest/
