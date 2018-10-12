# OpenStack Multi-Node Deployment
[![Build Status](https://travis-ci.org/electrocucaracha/openstack-multinode.png)](https://travis-ci.org/electrocucaracha/openstack-multinode)

This project offers instructions to deploy OpenStack services through
[Kolla][1] tool in a Multi-Node configuration. The deployment process
uses [node bash script](node.sh) to mount and format additional volumes
in the target Virtual Machines and other specialized scripts to setup
the [internal image registry](registry.sh) and the
[installer or undecloud](undercloud.sh) VM.

![Diagram](doc/img/diagram.png)

## Host System Requirements

The system that will host VMs for the solution must be big enough to support
the 11 VMs of the solution.

VM configuration can be adjusted at [pdf.yml](config/pdf.yml).

Current configuration:

* (1) Registry Node [Ram:16Gb, Cpu: 4, Disk: 50Gb]
* (3) Controllers Node [Ram:16Gb, Cpu:8]
* (1) Compute Node [Ram:64Gb, Cpu:16]
* (3) Network Nodes [Ram:8Gb, Cpu: 4]
* (1) Storage Node [Ram:8Gb, Cpu: 4]
* (1) Monitoring Node [Ram:8Gb, Cpu: 4]

**TOTALS**

| Element         | Size             |
|-----------------|------------------|
| Memory (RAM)    | 168Gb            |
| CPU             | 64 Logical Cores |
| Disk            | 150Gb            |

## Initial Setup

It uses [Vagrant tool][2] for provisioning Virtual Machines
automatically. The [setup](setup.sh) bash script contains the
Linux instructions to install dependencies and plugins required for
its usage. This script supports two Virtualization technologies
(Libvirt and VirtualBox).

    $ ./setup.sh -p libvirt

## Execution

First of all, it's necessary to start the nodes which are going to be
configured by the provisioning server. All these nodes can be
initialized in parallel using this commmand:

    $ export VAGRANT_DEFAULT_PROVIDER='libvirt'
    $ vagrant up

The registry node can be started in other session, this is an internal
Docker Hub of the OpenStack Kolla images will be consumed during the 
provisioning process.

    $ vagrant up registry

Finally, an additional node will be required which will be
responsible for the provisioning tasks.

    $ vagrant up undercloud

## License

Apache-2.0

[1]: https://docs.openstack.org/kolla/latest/
[2]: https://www.vagrantup.com/
