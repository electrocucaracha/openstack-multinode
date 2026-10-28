---
title: Extend an OpenStack Multi-Node deployment
---

# Extend an OpenStack Multi-Node deployment

You can adapt the sample deployments by changing Kolla settings, inventories,
host roles, service configuration, or VM topology.
Keep changes in the layer that owns the behavior: Kolla settings in
`etc/kolla/`, node setup in role scripts, and machine layout in the sample
Vagrant configuration and inventory.

Before changing a deployment, read [how it works](architecture.html) and
choose a baseline from the [deployment samples](index.html#choose-a-deployment).

## Change Kolla-Ansible settings

Set a supported `OS_KOLLA_` environment variable before provisioning.
The deployment scripts remove the prefix, lowercase the name, and write the
value to `/etc/kolla/globals.yml`.
For example:

```bash
export OS_KOLLA_ENABLE_HORIZON=yes
export OS_KOLLA_ENABLE_MAGNUM=yes
```

For Vagrant, export the settings before `vagrant up` so the Vagrant
configuration can pass them to its provisioner.
Check the selected sample's Vagrantfile: a sample may set a value explicitly
or override a value from the environment.

Use the value format expected by Kolla-Ansible for each setting.
For the available settings and their behavior, see the
[Kolla-Ansible configuration reference](https://docs.openstack.org/kolla-ansible/latest/reference/index.html).

## Use a different inventory

Create or adapt a Kolla-Ansible inventory and set `OS_INVENTORY_FILE` to its
path on the deployment host.
The inventory must describe the target hosts and their Kolla-Ansible groups.
Keep host addresses, names, and network interfaces consistent with the
machines that `node.sh` prepares.

For a Vagrant topology, update the sample's inventory and Vagrant definitions
together.
The no-HA Vagrantfile generates part of its inventory from
`OS_NUM_COMPUTE_NODES`; the distributed sample keeps its topology in
`samples/distributed/pdf.yml` and its inventory in
`samples/distributed/hosts.ini`.

## Add node-specific preparation

`node.sh` reads the space-separated `OPENSTACK_NODE_ROLES` variable.
For each role, it runs `<role>.sh` from the repository root when that file
exists.
To add node preparation:

1. Add a role script at the repository root, following the patterns in
   `controller.sh` or `compute.sh`.
2. Assign that role to the appropriate node through the Vagrant provisioner
   or your own provisioning process.
3. Run `node.sh` on a disposable test node and verify the resulting host
   configuration before using the role elsewhere.

Role scripts run with the node's provisioning environment and may use `sudo`.
Make their operations safe to repeat when provisioning may be retried.

## Add service configuration

For Kolla service overrides, add files under the matching directory in
`etc/kolla/config/`, following the existing examples for Cinder, Glance, and
Nova.
The installer copies the contents of `etc/kolla/` into `/etc/kolla/` before
deployment.
Check the upstream Kolla-Ansible service documentation for the supported
configuration paths and options.

To add project-specific post-deployment initialization, place a script under
`scripts/` and update `install.sh` to call it only when its corresponding
feature is enabled.
Follow the existing Cinder, Magnum, and Neutron trunk scripts.
Keep post-deployment initialization separate from host preparation and
Kolla-Ansible's deployment actions.

## Add or change a Vagrant topology

Use an existing sample as a starting point.
Update its Vagrantfile to define VM resources, networks, disks, and
provisioning commands.
Update its Kolla-Ansible inventory to match the resulting hosts and addresses.
If the sample needs a new base image, add its box metadata to
`distros_supported.yml` and ensure the matching distribution and release are
supported by the dependency files under `requirements/`.

Keep sample-specific defaults in that sample's Vagrant configuration.
Put defaults shared by the direct installer and deployment scripts in
`defaults.env` only when they are valid across those paths.

## Validate your changes

Run the repository linter before sharing a change:

```bash
make lint
```

Vagrant and provider availability are required to validate a topology
end to end.
Run the affected sample in a disposable environment, and verify that the
inventory, interfaces, storage devices, and resulting Kolla deployment match
your intended design.

## Related documentation

- [Install and use OpenStack Multi-Node](installation.html).
- [How the deployment works](architecture.html).
- [Neutron network types](neutron-network-types.html).
- [Contributing](https://github.com/electrocucaracha/openstack-multinode).
