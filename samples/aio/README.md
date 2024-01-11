# OpenStack All-in-One Configuration

This configuration was designed to host the OpenStack services in an [Intel's
NUC 10 Performance kit][1]. The [provisioning process](../../install.sh) pulls
the official Kolla images and deploys them in a CentOS 7 using the [undercloud
script](../../undercloud.sh).

The following diagram displays the Networking configuration created by
[init-runonce script][2].

![Diagram](../../doc/img/skydive_aio.png)

## Hardware Details

* 10th Generation Intel® Core™ i5-10210U Processor
* 256 GB NVMe SSD, 1 TB SATA3 HDD
* 16 GB Dual-Channel, LPDDR4-2666

## Vagrant execution

Once Vagrant is installed, it's possible to deploy an OpenStack cluster on
a single Virtual Machine.

```bash
vagrant up
```

### Environment variables

This table displays the environment variables used to configure some aspects of
the cluster, hardware resources and workflow.

| Name                     | Default | Description                                                     |
|:-------------------------|:--------|:----------------------------------------------------------------|
| OS_DISTRO                | centos  | Specifies the Linux distribution to be used for this deployment |
| ENABLE_WEAVE_SCOPE       |         | Enable/Disable [Weave Scope][3]                                 |
| OS_KOLLA_RUN_INIT        |         | Executes the [initialization Kolla script][2]                   |
| OS_KOLLA_ENABLE_MAGNUM   | no      | Enable/Disable [OpenStack Magnum service][4]                    |
| CPUS                     | 8       | Number of vCPUS assigned to the Virtual Machine                 |
| MEMORY                   | 16 GB   | Memory assigned to the Virtual Machine                          |

<!-- markdown-link-check-disable-next-line -->
[1]: https://ark.intel.com/content/www/us/en/ark/products/189239/intel-nuc-10-performance-kit-nuc10i5fnh.html
[2]: https://github.com/openstack/kolla-ansible/blob/10.0.0/tools/init-runonce
[3]: https://www.weave.works/oss/scope/
[4]: https://docs.openstack.org/magnum/latest/
