# OpenStack Distributed Configuration

![Diagram](../../doc/img/diagram_distributed.png)

## Host System Requirements

The system that will host VMs for the solution must be big enough to
support the +10 Virtual Machines displayed at above diagram.

Some configuration details can be configured for the _Distributed_
setup using its [PDF](pdf.yml).

### Current configuration

| Amount | Node               | Memory(GB) | vCPUs | Disk(GB) |
| ------ | ------------------ | ---------- | ----- | -------- |
| 1      | Registry           | 8          | 1     | 50       |
| 3      | Controller/Network | 8          | 1     |          |
| 1      | Compute            | 8          | 1     |          |
| 1      | Storage            | 8          | 1     | 100      |
| 1      | Monitoring         | 8          | 1     |          |
|        | Total              | 64         | 8     | 150      |

## Setup

Once Vagrant is installed, it's possible to deploy an OpenStack
cluster on Virtual Machines.

```bash
cd samples/distributed
```

First of all, it's necessary to start the cluster nodes which are
going to host the OpenStack services. Their roles are defined on the
[Ansible inventory file](hosts.ini) and used by the provisioning
server. All these nodes can be initialized in parallel using the
following command:

```bash
vagrant up
```

This instruction also starts the registry node, it is an internal
Docker Hub that contains OpenStack Kolla images that will be consumed
during the provisioning process.

Finally, the provisioning server will be required for the installation
and configuration tasks on target cluster nodes.

```bash
vagrant up undercloud
```
