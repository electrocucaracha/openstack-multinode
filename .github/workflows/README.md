# Available workflows

| Workflow file                          | Description                                                               | Run event                          |
| :------------------------------------- | ------------------------------------------------------------------------- | ---------------------------------- |
| [build](./build.yml)                   | Validates Kolla Docker images build and publish process                   | on new commit, scheduled or manual |
| [diagram](./diagram.yml)               | Generates the codebase diagram used by the main README.md file            | on new commit or push on master    |
| [distros](./distros.yml)               | Updates the Vagrant box versions for Distro list supported file           | scheduled or manual trigger        |
| [linter](./linter.yml)                 | Counts lines of code, verifies broken links in docs and runs linter tools | on new commit or push on master    |
| [on-demand_aio](./on-demand_aio.yml)   | Runs upgrade process in all-in-one setups in different supported distros  | on new commit or push on master    |
| [on-demand_noha](./on-demand_noha.yml) | Runs integration tests for No High Availability setup                     | on new commit or push on master    |
| [on-demand](./on-demand.yml)           | Verifies Bash scripts format                                              | on new commit or push on master    |
| [rebase](./rebase.yml)                 | Helps to rebase changes of the Pull Request                               | manual trigger                     |
| [scheduled_aio](./scheduled_aio.yml)   | Verifies all-in-one setups in different supported distros                 | scheduled or manual trigger        |
| [spell](./spell.yml)                   | Verifies spelling errors on documentation                                 | on new commit or push on master    |
| [update](./update.yml)                 | Updates Python requirements files and word list in the dictionary         | scheduled or manual trigger        |
