# OpenStack Multi-Node Deployment
[![Build Status](https://travis-ci.org/electrocucaracha/vagrant-kolla.png)](https://travis-ci.org/electrocucaracha/vagrant-kolla)

This project offers instructions to deploy OpenStack services through
[Kolla][1] tool in a Multi-Node configuration. The deployment process
uses [node bash script](node.sh) to mount and format additional volumes
in the target Virtual Machines and other specialized scripts to setup
the [internal image registry](registry.sh) and the
[installer or undecloud](undercloud.sh) VM.

## Initial Setup

This project uses [Vagrant tool][2] for provisioning Virtual Machines
automatically. The [setup](setup.sh) bash script contains the
Linux instructions to install dependencies and plugins required for
its usage. This script supports two Virtualization technologies
(Libvirt and VirtualBox).

    $ ./setup.sh -p libvirt

## Execution

    $ vagrant up
    $ vagrant up registry
    $ vagrant up undercloud

## License

Apache-2.0

[1]: https://docs.openstack.org/kolla/latest/
[2]: https://www.vagrantup.com/
