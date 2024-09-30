# Networks

To configure rich network topologies, you can create and configure networks and
subnets and instruct other OpenStack services like Compute to attach virtual
devices to ports on these networks.

## Provider Networks

Provider networks offer layer-2 connectivity to instances with optional support
for DHCP and metadata services. These networks connect, or map, to existing
layer-2 networks in the data center, typically using VLAN (802.1q) tagging to
identify and separate them.

- By default only administrators can create or update provider networks because
  they require configuration of physical network infrastructure.
- Provider networks only handle layer-2 connectivity for instances, thus lacking
  support for features such as routers and floating IP addresses.
- When a provider network is shared by an administrator, a project, user can
  view and attach their instances to it.

## Self-service or Tenant/Project Networks

Self-service networks primarily enable general (non-privileged) projects to
manage networks without involving administrators.

- These networks are entirely virtual and require virtual routers to interact
  with provider and external networks such as the internet.
- Usually provide DHCP and metadata services to instances.
- In most cases, self-service networks use overlay protocols such as VXLAN or
  GRE because they can support many more networks than layer-2 segmentation using
  VLAN tagging (802.1q).
- Floating IP addresses enable access to instances from provider networks via
  destination NAT on virtual routers.
- Contrary to provider networks that connect instances to the physical network
  infrastructure at layer-2, self-service networks must traverse a layer-3 agent.

Created by OpenStack users. Neutron automatically select a network
segmentation type like VXLAN or VLAN and users cannot select the segmentation
type.

The user in a project can articulate their own networking topology, completely
isolated from other projects in the same cloud, via the support of overlapping
IPs and other technologies.

## Summary

The primary difference between self-service and provider networks revolves
around who provisions them. Provider networks are created by the OpenStack
administrator on behalf of tenants and can be dedicated to a particular tenant,
shared by a subset of tenants (see RBAC for networks) or shared by all tenants.
On the other hand, self-service networks are created by tenants for use by their
instances and cannot be shared (based upon default policy settings).

| external-router | shared | Description                                                                                                                                                       |
| :-------------: | :----: | :---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|      false      | false  | Only usable by members of the tenant. Typically an overlay (vxlan, gre).                                                                                          |
|      false      |  true  | Shared by multiple tenants with RBAC on who can use it. Typically an overlay (vxlan, gre).                                                                        |
|      true       | false  | Scope is all tenants. Can only be created by administrators. Tenants connect their router for external access. Typically a ‘flat’ or ‘vlan’ network.              |
|      true       |  true  | Scope is all tenants. Can only be created by administrators. Tenants can connect directly to it. Typically known as a ‘provider’ network and is ‘flat’ or ‘vlan.’ |
