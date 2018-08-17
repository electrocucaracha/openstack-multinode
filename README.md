# OpenStack Kolla Deployment
[![Build Status](https://travis-ci.org/electrocucaracha/vagrant-kolla.png)](https://travis-ci.org/electrocucaracha/vagrant-kolla)

This project offers instructions to deploy OpenStack through [Kolla][1]
tool. The installation script includes the creation of Docker images
and the usage of those images to deploy the OpenStack services.

## Initial Setup
This project uses [Vagrant tool][2] for provisioning Virtual Machines
automatically. The [setup](setup.sh) bash script contains the
Linux instructions to install dependencies and plugins required for
its usage. This script supports two Virtualization technologies
(Libvirt and VirtualBox).

    $ ./setup.sh -p libvirt

## Execution

    $ vagrant up
    $ vagrant up installer

## License

Apache-2.0

[1]: https://docs.openstack.org/kolla/latest/
[2]: https://www.vagrantup.com/
