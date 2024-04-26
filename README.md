# OpenStack Multi-Node Deployment
<!-- markdown-link-check-disable-next-line -->
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![GitHub Super-Linter](https://github.com/electrocucaracha/openstack-multinode/workflows/Lint%20Code%20Base/badge.svg)](https://github.com/marketplace/actions/super-linter)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
<!-- markdown-link-check-disable-next-line -->
![visitors](https://visitor-badge.laobi.icu/badge?page_id=electrocucaracha.openstack-multinode)
[![Scc Code Badge](https://sloc.xyz/github/electrocucaracha/openstack-multinode?category=code)](https://github.com/boyter/scc/)
[![Scc COCOMO Badge](https://sloc.xyz/github/electrocucaracha/openstack-multinode?category=cocomo)](https://github.com/boyter/scc/)

Package based management has been replaced by container based
management systems which help to solve the availability, management
and scalability aspects of deployment. These are some of the benefits
of using a containerized deployment:

* ~~**OS agnostic:** Ability to run on any platform, regardless of the
physical host OS.~~
* **Easy to scale up/down:** The operation to add/remove OpenStack
compute nodes is performed through starting/stopping containers.
* **Fast deployment:** Containers already have binaries and
configuration files so provisioning an OpenStack cluster can take
few minutes.
* **Easy to rollback:** Installing, patching or upgrading operations
are atomic, either they will successfully complete or will fail. In
case of failure, they can be removed and the system is back to its old
state.
* **In-place updates:** Instead of rolling-updates, one can follow the
pattern on in-place updates. Whenever a new image is available, one
can simply stop the old-container and start a new container with the
latest image.
* **Enabling/disabling services easily:** Given that everything is
containerized, adding/removing services is now like starting/stopping
containers.
* **Self-healing deployment:** Services can be managed by Kubernetes
or Docker Swarm and failed containers can be automatically restarted.
This results in a self-healing deployment.
* **Immutable and portable:** Images once built don’t change over
time. Hence, you can recreate the same setup on different
days/different environments with exact same piece of code running.
Also, since everything is containerized, it can be moved from one
place to another with ease.

Almost all the technology giants have been shift their focus to
container based architecture.

[Kolla][1](from [Greek][2] "κολλα" which means "glue") is an OpenStack
project which aims to provide production-ready containers for OpenStack
deployment and management. This repository offers instructions to deploy
OpenStack services through the use of [Kolla][1] installer in the following
configurations:

* [All-in-One](samples/aio/): OpenStack Controller and Compute roles
installed on a single CentOS Stream 8 server. This configuration is
limited so it's recommended only for Development purposes.
* [No High Availability](samples/noha/): Kolla Docker Registry and
OpenStack Controller role installed on a single Ubuntu Focal server. Two
additional servers are provisioned with OpenStack Compute role. This
configuration is useful to test distributed applications.
* [Distributed](samples/distributed/): Every role is distributed among
several Ubuntu servers. This configuration pretends to mimic the needs
of a production environment.

The deployment process uses [node bash script](node.sh) to mount and
format additional volumes in the target Virtual Machines and other
specialized scripts to setup additional roles, like the
[internal image registry](registry.sh). The [undercloud](undercloud.sh)
Virtual Machine is used to provision other servers.

## Deploy All-in-One configuration

The [install bash script](install.sh) provides instructions to
deploy an All-in-One OpenStack configuration. It's possible to run
this script remotely:

```bash
curl -fsSL https://raw.githubusercontent.com/electrocucaracha/openstack-multinode/master/install.sh | OS_KOLLA_NETWORK_INTERFACE=eno1 bash
```

## Contribution

This is an open project, several individuals contribute in different forms like
coding, documenting, testing, spreading the word at events within others.

Thanks to all the people who already contributed!

<a href="https://github.com/electrocucaracha/openstack-multinode/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=electrocucaracha/openstack-multinode" />
</a>

![Visualization of the codebase](./codebase-structure.svg)

[1]: https://docs.openstack.org/kolla/latest/
[2]: https://lists.openstack.org/pipermail/openstack-dev/2014-September/046911.html
