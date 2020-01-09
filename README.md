# OpenStack Multi-Node Deployment
[![Build Status](https://travis-ci.org/electrocucaracha/openstack-multinode.png)](https://travis-ci.org/electrocucaracha/openstack-multinode)

This project offers instructions to deploy OpenStack services through
[Kolla][1] tool in the following configurations:

* [All-in-One](samples/aio/): Kolla Docker Registry, OpenStack
Controller and Compute roles installed on a single Ubuntu Xenial
server. This configuration is limited so it's recommended only for
Development purposes.
* [No High Availability](samples/noha/): Kolla Docker Registry and
OpenStack Controller role installed on a single CentOS 7 server. Two
additional servers are provisioned with OpenStack Compute role. This
configuration is useful to test distributed applications.
* [Distributed](samples/distributed/): Every role is distributed among
several Ubuntu servers. This configuration pretends to mimic the needs
of a production environment.

The deployment process uses [node bash script](node.sh) to mount and
format additional volumes in the target Virtual Machines and other
specialized scripts to setup additional roles, like the
[internal image registry](registry.sh). The [undecloud](undercloud.sh)
Virtual Machine is used to provision other servers.

![Diagram](doc/img/diagram.png)

## Host System Requirements

The system that will host VMs for the solution must be big enough to
support the +10 Virtual Machines displayed at above diagram.

Some configuration details can be configured for the *Distributed*
setup using its [pdf.yml](samples/distributed/pdf.yml).

### Current configuration

| Amount | Element           | Memory(GB) | vCPUs | Disk(GB) |
|--------|-------------------|------------|-------|----------|
| 1      | Registry Node     | 16         | 4     | 50       |
| 3      | Controller Node   | 16         | 8     |          |
| 1      | Compute Node      | 64         | 16    |          |
| 3      | Network Node      | 8          | 4     |          |
| 1      | Storage Node      | 8          | 4     |          |
| 1      | Monitoring Node   | 8          | 4     |          |
|        | Total             | 168        | 64    | 50       |

## Initial Setup

## Setup

This project uses [Vagrant tool][2] for provisioning Virtual Machines
automatically. It's highly recommended to use the  *setup.sh* script
of the [bootstrap-vagrant project][3] for installing Vagrant
dependencies and plugins required for its project. The script
supports two Virtualization providers (Libvirt and VirtualBox).

    $ curl -fsSL http://bit.ly/initVagrant | PROVIDER=libvirt bash

Once Vagrant is installed, it's possible to deploy the demo with the
following instructions:

    $ cd samples/distributed
    $ vagrant up
    $ vagrant up undercloud

### Explanation

First of all, it's necessary to start the nodes which are going to be
configured by the provisioning server. All these nodes can be
initialized in parallel using this commmand:

    $ vagrant up

This also starts the registry node, it is an internal Docker Hub that
contains OpenStack Kolla images that will be consumed during the
provisioning process.

Finally, an additional node will be required which will be
responsible for the provisioning tasks.

    $ vagrant up undercloud

## Dashboards

| Service | URL                    |
|---------|------------------------|
| Horizon | http://10.10.13.3:80   |
| Skydive | http://10.10.13.3:8085 |


## Deploy All-in-One configuration

The [install bash script](install.sh) provides instructions to 
deploy an All-in-One OpenStack configuration. It's possible to run
this script remotely:

    $ curl -fsSL https://raw.githubusercontent.com/electrocucaracha/openstack-multinode/master/install.sh | bash

## License

Apache-2.0

[1]: https://docs.openstack.org/kolla/latest/
[2]: https://www.vagrantup.com/
[3]: https://github.com/electrocucaracha/bootstrap-vagrant
