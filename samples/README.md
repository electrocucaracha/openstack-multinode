# Samples

This folder contains several Vagrant configurations which can be used to
provision Virtual Machines for testing different deployment
configurations.

Each sample contains a `README.md` file with specific instructions.

The current samples are:

- `aio`: All-in-one configuration
- `noha`: No High Availability configuration
- `distributed`: Distributed configuration

See the specific sample folders for more details.

## Vagrant Configuration

This project provides configurations which have been validated
using [Vagrant tool][1] on Virtual Machines provisioned on VirtualBox
or Libvirt. It's highly recommended to use the _setup.sh_ script
of the [bootstrap-vagrant project][2] for installing Vagrant
dependencies and plugins required for its project.

```bash
curl -fsSL http://bit.ly/initVagrant | PROVIDER=libvirt bash
```

The **setup.sh** script supports VirtualBox and Libvirt providers.

[1]: https://www.vagrantup.com/
[2]: https://github.com/electrocucaracha/bootstrap-vagrant
