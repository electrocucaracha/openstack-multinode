# OpenStack network types

OpenStack Networking (Neutron) lets you create networks and subnets, then
connect instances and other services to them.
This page summarizes the difference between provider networks and
self-service networks.

For deployment-specific Neutron configuration, see the
[Kolla-Ansible networking reference](https://docs.openstack.org/kolla-ansible/latest/reference/networking/neutron.html).

## Provider networks

Provider networks map directly to existing layer 2 networks in the
infrastructure.
They can use flat or VLAN segmentation, depending on the cloud's configuration.

Cloud administrators generally create provider networks because they depend on
physical network configuration.
An administrator can make a provider network available to one or more projects
through the cloud's sharing and role-based access control policies.

Provider networks connect instances to the mapped layer 2 network.
They do not provide Neutron routers or floating IP addresses by themselves.

## Self-service networks

Self-service networks let project users create networks without asking an
administrator to configure a physical network for each one.
They usually use an overlay technology such as VXLAN or GRE.
The cloud administrator configures which network types and segmentation ranges
are available; Neutron selects from that configured set when a project creates
a network.

To reach an external network, a self-service network normally connects to a
Neutron router.
The router can provide source NAT for outbound traffic and can associate
floating IP addresses with instances for inbound connections.
DHCP and metadata services can also be provided to instances, subject to the
cloud's configuration.

Because Neutron routes traffic between self-service and external networks,
the network nodes and agents must be configured to support that path.

## Comparison

| Network      | Typical creator     | Typical segmentation                          | Routing                                         |
| ------------ | ------------------- | --------------------------------------------- | ----------------------------------------------- |
| Provider     | Cloud administrator | Flat or VLAN                                  | Not provided by the network itself              |
| Self-service | Project user        | VXLAN, GRE, or another configured tenant type | Uses a Neutron router for external connectivity |

The exact permissions and available network types depend on the cloud's
Neutron policy and configuration.
