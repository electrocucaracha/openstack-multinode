# OpenStack All-in-One Configuration

This configuration was designed to host the OpenStack services in an
[Intel's NUC NUC10i7FNHAA1][1]. The [provisioning process](../../install.sh)
pulls the official Kolla images and deploys them in a CentOS 7 using the 
[undercloud script](../../undercloud.sh).

The following diagram displays the Networking configuration created
by [init-runonce script][2].

![Diagram](../../doc/img/skydive_aio.png)

## Hardware Details

* 10th Generation Intel® Core™ i7-10710U Processor
* 256 GB NVMe SSD, 1 TB SATA3 HDD
* 16 GB Dual-Channel, LPDDR4-2666

## Vagrant execution

Once Vagrant is installed, it's possible to deploy an OpenStack
cluster on a single Virtual Machine.

    $ cd samples/aio
    $ vagrant up

## Dashboards

| Service | URL             |
|---------|-----------------|
| Horizon | http://aio      |
| Skydive | http://aio:8085 |

[1]: https://www.intel.com/content/www/us/en/products/docs/boards-kits/nuc/nuc-family-overview.html
[2]: https://github.com/openstack/kolla-ansible/blob/9.0.1/tools/init-runonce
