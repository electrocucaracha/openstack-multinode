---
title: Deploy no-HA OpenStack on Raspberry Pi 4
---

# Deploy no-HA OpenStack on Raspberry Pi 4

This guide deploys the repository's no-high-availability (no-HA) OpenStack
configuration on three Raspberry Pi 4 nodes, with a separate jumpbox. It uses
the repository's Kolla-Ansible installer and inventory layout.

This is a homelab configuration, not a highly available or production
architecture. The repository's no-HA continuous integration test uses Vagrant
virtual machines; it does not validate a bare-metal Raspberry Pi deployment.

## Topology

This guide assumes the following mapping. The jumpbox is an administration
host and does not run an OpenStack role.

| Host           | Role                               | Management (`eth0`) | Wi-Fi (`wlan0`) |
| -------------- | ---------------------------------- | ------------------- | --------------- |
| `rasp4-node02` | Jumpbox                            | `10.10.0.3`         | `192.168.1.13`  |
| `rasp4-node03` | Controller                         | `10.10.0.4`         | `192.168.1.14`  |
| `rasp4-node04` | Compute 1 and Neutron network node | `10.10.0.5`         | `192.168.1.15`  |
| `rasp4-node05` | Compute 2 and Neutron network node | `10.10.0.6`         | `192.168.1.16`  |

The management addresses must be static or reserved, and all OpenStack nodes
must reach each other over `10.10.0.0/24`. The host operating systems use
`wlan0` for package and image downloads. Kolla uses `eth0` for management,
API, and tunnel traffic.

### Neutron external network

The repository's default no-HA inventory places both compute nodes in the
`[network]` group. With provider networks enabled as shown in this guide, attach
a dedicated wired interface to each compute node for Neutron's external
network. A Raspberry Pi 4 has one built-in Ethernet port, so this default
layout assumes a USB Ethernet adapter named `eth1` on each compute node.
Connect both adapters to the same home LAN as the router at `192.168.1.1`.

Keep the external interface dedicated to Neutron and without a host IP address.
Do not use `wlan0` as the Neutron external interface: a Wi-Fi client interface
usually cannot provide the layer-2 bridge this Open vSwitch setup requires.
Do not use the management interface for Neutron external traffic.

The host and VM internet paths are separate in the default layout:

```text
Host package downloads:
  controller/compute wlan0 -> home router (192.168.1.1) -> Internet

VM egress:
  tenant network -> Neutron router -> compute br-ex/eth1
  -> home router (192.168.1.1) -> Internet

Management and VXLAN:
  controller eth0 (10.10.0.4) ---+
  compute04  eth0 (10.10.0.5) ---+--- 10.10.0.0/24
  compute05  eth0 (10.10.0.6) ---+
```

Reserve `192.168.1.200` through `192.168.1.220` outside the router's DHCP pool.
The sample's provider-network setup will not give VMs internet access over the
listed Wi-Fi interface. See the centralized option below if you want to use one
wired external interface instead of one on each compute node.

### Centralized network-node option

You can place the Neutron `[network]` role on the controller and centralize
external routing there. In that layout, the controller needs the wired USB
Ethernet adapter; the compute nodes can use the management network for tunneled
VM traffic without their own external adapters, provided you disable provider
networks on compute hosts and leave distributed virtual routing disabled.

```text
VM on compute04/compute05
  |
  v
Tenant network and compute OVS agent
  |
  | VXLAN over eth0 / 10.10.0.0/24
  v
Controller Neutron network/L3 role
  |
  | br-ex -> USB eth1
  v
Home router (192.168.1.1) -> Internet
```

This distinction matters because Kolla-Ansible 2025.1 configures the external
interface on `[network]` hosts and also on `[compute]` hosts when provider
networks or distributed virtual routing are enabled. The main configuration
below enables provider networks, so merely moving `[network]` to the controller
does **not** remove the compute-node adapter requirement. See the
[Kolla-Ansible 2025.1 Neutron interface requirements](https://docs.openstack.org/kolla-ansible/2025.1/reference/networking/neutron.html).

For a centralized variant, use these inventory groups instead of the default
groups in `header.ini`:

```ini
[control]
rasp4-node03 ansible_host=10.10.0.4 ansible_user=ubuntu

[network]
rasp4-node03

[compute]
rasp4-node04 ansible_host=10.10.0.5 ansible_user=ubuntu
rasp4-node05 ansible_host=10.10.0.6 ansible_user=ubuntu

[storage]
rasp4-node04
rasp4-node05

[monitoring]
rasp4-node03
```

Append `tail.ini` as described below. In this variant, set
`OS_KOLLA_ENABLE_NEUTRON_PROVIDER_NETWORKS=no`, keep distributed virtual
routing disabled, and set `OS_KOLLA_NEUTRON_EXTERNAL_INTERFACE=eth1` to the
controller's USB adapter. Use tenant networks connected to a Neutron router
for VM egress. This does not provide direct provider-network attachment on the
compute nodes. The central network node is a single point of failure, and this
variant is not covered by the repository's Vagrant test; validate the Kolla
inventory and traffic path before relying on it.

## Prerequisites

- Four Raspberry Pi 4 systems: one jumpbox, one controller, and two compute
  nodes. The repository's Vagrant sample assigns 8 GB to the controller and
  4 GB to each compute node.
- A 64-bit Ubuntu Server installation on each OpenStack node. For release
  `2025.1`, this repository includes Ubuntu 24.04 dependency pins. The Vagrant
  no-HA test runs on virtual machines and does not establish bare-metal ARM64
  compatibility; validate the image architecture and deployment in your lab.
- Internet access from each host operating system, normally through `wlan0`.
- For the default layout, a working USB Ethernet adapter on each compute node,
  connected to the same `192.168.1.0/24` LAN as the router. For the centralized
  variant, connect one adapter to the controller instead.
- Static management addresses, resolvable hostnames (or inventory
  `ansible_host` entries), and synchronized system clocks.
- An SSH account that the controller can use on both compute nodes, with
  passwordless `sudo` on all three OpenStack nodes. The controller account
  must also pass `sudo -n true`.
- Enough controller storage and memory for the local Kolla image build and
  registry. Building images locally takes significant time and disk space.

Before deployment, confirm the interfaces and routes on each node:

```bash
ip -br -4 address
ip route
ip route get 1.1.1.1
```

Confirm `eth0` has the expected `10.10.0.x` address and the default route uses
`wlan0`. For the default layout, confirm the Neutron interface name on each
compute node. For the centralized variant, check it on the controller:

```bash
ip link show eth1
```

Interface names can differ between adapters. If your adapters do not appear as
`eth1`, use their actual names consistently or set the Neutron interface per
host in the Ansible inventory.

## Prepare the nodes

Install Git and clone this repository on the controller and each compute node.
Run the node setup script on each OpenStack node as the deployment account:

```bash
sudo apt-get update
sudo apt-get install -y git
git clone https://github.com/electrocucaracha/openstack-multinode.git \
  "$HOME/openstack-multinode"
cd "$HOME/openstack-multinode"
./node.sh
```

From the controller, verify passwordless SSH to both compute nodes using the
same account that you will put in the inventory:

```bash
ssh ubuntu@10.10.0.5 'sudo -n true'
ssh ubuntu@10.10.0.6 'sudo -n true'
```

Replace `ubuntu` if you use a different account. Do not continue until these
commands succeed without prompting for a password.

## Create the inventory

On the controller, create the host-group portion of the inventory. The example
uses the Ubuntu Server account `ubuntu` and the supplied addresses:

```bash
cd "$HOME/openstack-multinode/samples/noha"
cat > header.ini <<'EOF'
[control]
rasp4-node03 ansible_host=10.10.0.4 ansible_user=ubuntu

[network]
rasp4-node04 ansible_host=10.10.0.5 ansible_user=ubuntu
rasp4-node05 ansible_host=10.10.0.6 ansible_user=ubuntu

[compute]
rasp4-node04
rasp4-node05

[storage]
rasp4-node04
rasp4-node05

[monitoring]
rasp4-node03
EOF
cat header.ini tail.ini > hosts.ini
```

The `tail.ini` file supplies the Kolla service groups used by the no-HA
sample. The jumpbox is intentionally not in the inventory. If you use a
different SSH account, change `ansible_user` in `header.ini` before building
`hosts.ini`.

## Configure the deployment

Run the following commands on the controller. Change the external subnet,
gateway, allocation range, or interface names if your LAN differs. The
external range must not overlap DHCP leases or static addresses.

```bash
export OS_FOLDER="$HOME/openstack-multinode"
export OPENSTACK_RELEASE=2025.1
export OS_INVENTORY_FILE="$OS_FOLDER/samples/noha/hosts.ini"

export OS_KOLLA_NETWORK_INTERFACE=eth0
export OS_KOLLA_API_INTERFACE=eth0
export OS_KOLLA_TUNNEL_INTERFACE=eth0
export OS_KOLLA_KOLLA_INTERNAL_VIP_ADDRESS=10.10.0.4

export OS_KOLLA_NEUTRON_EXTERNAL_INTERFACE=eth1
export OS_KOLLA_ENABLE_NEUTRON_PROVIDER_NETWORKS=yes
export EXT_NET_CIDR=192.168.1.0/24
export EXT_NET_GATEWAY=192.168.1.1
export EXT_NET_RANGE=start=192.168.1.200,end=192.168.1.220

export OS_ENABLE_LOCAL_REGISTRY=true
```

`OS_ENABLE_LOCAL_REGISTRY=true` follows the no-HA Vagrant sample and builds
images on the controller before deployment. Keep it enabled for this ARM64
setup unless you have verified that the image registry you use provides
compatible images for your selected release and architecture.

`OS_KOLLA_KOLLA_INTERNAL_VIP_ADDRESS` is the controller's management address
in this single-controller configuration; it is not a separate floating IP.
The installer now honors `OS_KOLLA_NETWORK_INTERFACE` when it discovers that
address, even though the host's default route uses Wi-Fi.

## Deploy OpenStack

On the controller, with the environment variables above exported, run:

```bash
cd "$OS_FOLDER"
./install.sh
```

The installer uses the inventory at `OS_INVENTORY_FILE`, configures Kolla, and
runs its post-deployment initialization. Keep the controller connected to the
internet through `wlan0` during package installation and image build. The
compute nodes also need host internet access while `node.sh` installs their
dependencies.

## Verify VM internet access

After deployment:

1. Check the OpenStack services and networks from the controller after loading
   the generated OpenStack credentials in `/etc/kolla/admin-openrc.sh`.
2. Create a tenant network, subnet, and router, and set the router's external
   gateway to the external/provider network created by initialization.
3. Launch a test VM on the tenant network and confirm it receives an address,
   has a default route, resolves DNS, and can reach an internet host.

Outbound access uses Neutron router source NAT through the external network. A
floating IP is needed for inbound connections to a VM, not for ordinary
outbound internet access. If the VM has no egress, check that the external
allocation range is unused, both compute-node `eth1` adapters reach the same
LAN, the router gateway is correct, and the tenant router has an external
gateway.

## GitHub Pages

This repository does not currently include a Pages workflow or site
configuration. To publish this `docs/` directory, enable GitHub Pages in the
repository settings and select the deployment source that publishes the
`docs/` folder on your default branch. The entry page is `docs/index.md`.

For the Vagrant workflow, see the
[no-HA sample guide](sample-noha.html).
