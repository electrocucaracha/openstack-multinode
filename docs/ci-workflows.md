# Continuous integration workflows

The workflows under `.github/workflows/` validate scripts, documentation,
deployment samples, and generated assets.

| Workflow                                                                                                                   | Purpose                                                            | Trigger                                                           |
| -------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ | ----------------------------------------------------------------- |
| [build](https://github.com/electrocucaracha/openstack-multinode/blob/master/.github/workflows/build.yml)                   | Builds and publishes Kolla container images                        | Matching push, submitted pull request review, schedule, or manual |
| [diagram](https://github.com/electrocucaracha/openstack-multinode/blob/master/.github/workflows/diagram.yml)               | Generates the codebase diagram used by the root readme             | Push or manual                                                    |
| [distros](https://github.com/electrocucaracha/openstack-multinode/blob/master/.github/workflows/distros.yml)               | Updates supported Vagrant box versions                             | Scheduled or manual                                               |
| [linter](https://github.com/electrocucaracha/openstack-multinode/blob/master/.github/workflows/linter.yml)                 | Counts lines of code, checks documentation links, and runs linters | Push or pull request                                              |
| [on-demand_aio](https://github.com/electrocucaracha/openstack-multinode/blob/master/.github/workflows/on-demand_aio.yml)   | Tests all-in-one deployments across supported distributions        | Matching push or submitted pull request review                    |
| [on-demand_noha](https://github.com/electrocucaracha/openstack-multinode/blob/master/.github/workflows/on-demand_noha.yml) | Runs no-HA integration tests                                       | Matching push or submitted pull request review                    |
| [on-demand](https://github.com/electrocucaracha/openstack-multinode/blob/master/.github/workflows/on-demand.yml)           | Checks Bash formatting                                             | Matching push or submitted pull request review                    |
| [scheduled_aio](https://github.com/electrocucaracha/openstack-multinode/blob/master/.github/workflows/scheduled_aio.yml)   | Tests all-in-one deployments across supported distributions        | Scheduled or manual                                               |
| [update](https://github.com/electrocucaracha/openstack-multinode/blob/master/.github/workflows/update.yml)                 | Updates Python requirements and the spelling dictionary            | Scheduled or manual                                               |

## All-in-one release selection

The all-in-one virtual machine matrix uses entries from
[distros_supported.yml](https://github.com/electrocucaracha/openstack-multinode/blob/master/distros_supported.yml)
that have a matching requirements file among the third release entry and the
two entries before it in
[releases.txt](https://github.com/electrocucaracha/openstack-multinode/blob/master/releases.txt).
The on-demand workflow deploys the newest matching release in that range and
then tests upgrades.
The scheduled workflow deploys the latest release.

A Vagrant box being available does not guarantee that Kolla-Ansible supports
the corresponding distribution and OpenStack release.
An empty matrix, or a direct all-in-one deployment request without a matching
requirements file, fails rather than silently skipping the deployment.

Run the release-selection checks from the repository root:

```bash
bash ci/test_aio_releases.sh
```

## VirtualBox setup on Linux runners

The shared
[Vagrant setup action](https://github.com/electrocucaracha/openstack-multinode/blob/master/.github/actions/vagrant-setup/action.yml) checks for
the `vboxdrv` module before starting Vagrant.
If needed, it installs the build tools and headers for the running kernel,
rebuilds the VirtualBox modules, and retries loading them.
Linux VM runners need an existing VirtualBox installation, `apt-get`, and
passwordless `sudo`.
Kernel compatibility and Secure Boot signing issues still require runner
maintenance.
