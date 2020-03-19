# OpenStack Distributed Configuration

![Diagram](../../doc/img/diagram.png)

## Host System Requirements

The system that will host VMs for the solution must be big enough to
support the +10 Virtual Machines displayed at above diagram.

Some configuration details can be configured for the *Distributed*
setup using its [pdf.yml](pdf.yml).

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

## Setup

Once Vagrant is installed, it's possible to deploy an OpenStack
cluster on Virtual Machines.

    $ cd samples/distributed

First of all, it's necessary to start the cluster nodes which are
going to host the OpenStack services. Their roles are defined on the
[Ansible inventory file](hosts.ini) and used by the provisioning
server. All these nodes can be initialized in parallel using the
following commmand:

    $ vagrant up

This instruction also starts the registry node, it is an internal
Docker Hub that contains OpenStack Kolla images that will be consumed
during the provisioning process.

Finally, the provisioning server will be required for the installation
and configuration tasks on target cluster nodes.

    $ vagrant up undercloud

## Dashboards

| Service | URL                    |
|---------|------------------------|
| Horizon | http://10.10.13.3      |
| Skydive | http://10.10.13.3:8085 |


## License

Apache-2.0
