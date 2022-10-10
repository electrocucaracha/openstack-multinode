# Available workflows

| Workflow file                                  | Description                                                                  | Run event                              |
| :--------------------------------------------- | ---------------------------------------------------------------------------- | -------------------------------------- |
| [build](./build.yml)                           | Validates Kolla Docker images build and publish process                      | on new commit/scheduled/manual trigger |
| [diagram](./diagram.yml)                       | Generates the codebase diagram used by the main README.md file               | on new commit/push on master           |
| [distros](./distros.yml)                       | Updates the Vagrant box versions for Distro list supported file              | scheduled/manual trigger               |
| [linter](./linter.yml)                         | Verifies broken links in documentation and runs multiple linter tools        | on new commit/push on master           |
| [on-demand_aio](./on-demand_aio.yml)           | Runs upgrade process in all in one setups in different supported distros     | on new commit/push on master           |
| [on-demand_noha](./on-demand_noha.yml)         | Runs integration tests for No High Availability setup                        | on new commit/push on master           |
| [on-demand](./on-demand.yml)                   | Verifies bash scripts format                                                 | on new commit/push on master           |
| [rebase](./rebase.yml)                         | Helps to rebase changes of the Pull request                                  | manual trigger                         |
| [scheduled_aio](./scheduled_aio.yml)           | Verifies all in one setups inf different supported distros                   | scheduled/manual trigger               |
| [spell](./spell.yml)                           | Verifies spelling errors on documentation                                    | on new commit/push on master           |
| [update](./update.yml)                         | Updates python requirements files and word list in the dict.                 | scheduled/manual trigger               |
