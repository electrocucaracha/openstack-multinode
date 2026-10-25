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

## Deployment examples

- [All-in-one](docs/sample-aio.md): run the OpenStack services on one VM.
- [No high availability](docs/sample-noha.md): run a controller and compute
  nodes, using Vagrant or physical Raspberry Pi hardware.
- [Distributed](docs/sample-distributed.md): provision a multi-VM topology
  with separate controller, compute, storage, registry, and monitoring roles.

For prerequisites, setup guidance, and networking references, start at the
[documentation index](docs/index.md).

The deployment scripts prepare nodes, configure Kolla-Ansible, and optionally
build and publish container images to a local registry.
See [install.sh](install.sh), [node.sh](node.sh), and
[registry.sh](registry.sh) for the implementation.

![Codebase structure](./codebase-structure.svg)

## Contributing

Contributions are welcome, including code, documentation, testing, and
community outreach.

![Contributors](https://contrib.rocks/image?repo=electrocucaracha/openstack-multinode)

[1]: https://docs.openstack.org/kolla-ansible/latest/
