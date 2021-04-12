# OpenStack No High Availability Configuration

This configuration was designed to create a minimal OpenStack cluster
using [Intel's NUCs NUC10i7FNHAA1][1] without High Availability. The
[provisioning process](../../install.sh) is executed on the Controller
node and creates a local registry on it using the
[registry script](../../registry.sh) and deploys OpenStack services
using the [undercloud script](../../undercloud.sh).

The following diagram shows the distribution of OpenStack Kolla
containers created by this configuration.

![Diagram](../../doc/img/containers_noha.png)

## Vagrant execution

Once Vagrant is installed, it's possible to deploy an OpenStack
cluster on Virtual Machines.

```bash
cd samples/noha
vagrant up
vagrant up controller01
```

## Dashboards

| Service | URL                   |
|---------|-----------------------|
| Horizon | <http://controller01> |

[1]: https://www.intel.com/content/www/us/en/products/docs/boards-kits/nuc/nuc-family-overview.html
