# OpenStack Kolla Deployment

This project offers instructions to deploy OpenStack through [Kolla][1]
tool. The installation script includes the creation of Docker images
and the usage of those images to deploy the OpenStack services.

## Requirements

  * [Vagrant][2]
  * [VirtualBox][3] or [Libvirt][4]

## Execution

    $ git clone http://github.com/electrocucaracha/vagrant-kolla
    $ cd vagrant-kolla
    $ vagrant up
    $ vagrant up installer

## License

Apache-2.0

[1]: https://docs.openstack.org/kolla/latest/
[2]: https://www.vagrantup.com/downloads.html
[3]: https://www.virtualbox.org/wiki/Downloads
[4]: http://libvirt.org/downloads.html
