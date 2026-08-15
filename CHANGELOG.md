<!-- Markdownlint-disable MD024 -->

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [32.2.0] - 2026-08-11

### Added

- A comprehensive changelog was introduced to track all significant updates, additions, removals, and fixes throughout the project's history, adhering to Keep a Changelog and Semantic Versioning standards. [c8ef809e](https://github.com/electrocucaracha/openstack-multinode/commit/c8ef809e812508e19cfe44f2a7cffddba5d3ef25)

## [32.1.1] - 2026-08-01

### Changed

- Upgraded OpenStack Kolla dependencies to updated versions of various packages including certifi, cffi, charset-normalizer, cliff, cmd2, cryptography, netaddr, oslo-config, oslo-i18n, pbr, prettytable, prompt-toolkit, psutil, rich, rich-argparse, setuptools, stevedore, urllib3, and wcwidth. [7c70d0ec](https://github.com/electrocucaracha/openstack-multinode/commit/7c70d0ec94966ad98ede48da9959dbe57cf6d22f)

## [32.1.0] - 2026-07-27

### Added

- Enabled ProxySQL by default in all deployments to provide advanced MySQL load balancing and high availability features unless explicitly disabled, addressing previous issues where ProxySQL-dependent services failed due to the service being off by default. [fe5103a3](https://github.com/electrocucaracha/openstack-multinode/commit/fe5103a34448f7cabbfbe717ddd776656e4b05ef)

## [32.0.5] - 2026-07-26

### Fixed

- Renamed the kolla_logs group to kolla-logs for consistency with the hyphenated naming convention used elsewhere, improving clarity and preventing confusion during automation or referencing, and requiring existing playbooks or scripts referencing the old group name to be updated accordingly. [e03e77ec](https://github.com/electrocucaracha/openstack-multinode/commit/e03e77ec521a2be89a6f7158f8b29197ec5d363e)

## [32.0.4] - 2026-07-26

### Changed

- Optimized environment variable definitions in build.yml by collapsing multiline variables into single lines and updated .yamlfmt configuration to increase max_line_length from 160 to 250 characters, eliminating formatting noise while preserving API contract integrity. [e2d8ab85](https://github.com/electrocucaracha/openstack-multinode/commit/e2d8ab8571e8d4ce36f1eec3e845fce1350ba637)

## [32.0.3] - 2026-07-26

### Fixed

- Resolved Ansible lookup errors during deployment by correcting the group name for kolla-toolbox from using an underscore to a hyphen, ensuring consistency with other group names and not affecting any other groups. [6574b450](https://github.com/electrocucaracha/openstack-multinode/commit/6574b45083f42173c7b5e91d91d44a8859ca3482)

## [32.0.2] - 2026-07-26

### Fixed

- Stabilized release selection logic in check_aio.sh to prevent infinite loops and invalid references by safely decrementing the pointer and checking for the requirements file. [9d3fdbc5](https://github.com/electrocucaracha/openstack-multinode/commit/9d3fdbc59d2ffa5e90d562c221442d3395520caf)

## [32.0.1] - 2026-07-26

### Changed

- Updated the ai-prepare-commit-msg hook to ensure compatibility with recent upstream improvements and bug fixes, potentially improving commit message suggestions and overall hook reliability without requiring configuration changes. [b412068a](https://github.com/electrocucaracha/openstack-multinode/commit/b412068a85508dae7ac6aa3f1e5a0585a5048d20)

## [32.0.0] - 2026-07-26

### Removed

- Updated workflows to default to Ubuntu 24.04 (Noble) and removed references to Ubuntu 22.04 from workflow files, ensuring compatibility with the latest LTS release and reducing maintenance overhead for older versions. [b16ef3d9](https://github.com/electrocucaracha/openstack-multinode/commit/b16ef3d9a6f2b408c7ea7536fa8213d3b914b9ce)

## [31.3.0] - 2026-06-29

### Added

- Enabled streamlined linter runs by disabling super-linter ENV validation, allowing the tool to focus on applicable checks and reducing noise in CI workflows without introducing breaking behavior or requiring migration steps. [d2b84fe1](https://github.com/electrocucaracha/openstack-multinode/commit/d2b84fe165343a97e42f1cd17500c2664c00fdda)

## [31.2.0] - 2026-06-29

### Added

- Enabled streamlined linting by disabling redundant pre-commit and codespell validations in the super-linter workflow without impacting other linting steps or code quality enforcement. [589aeda9](https://github.com/electrocucaracha/openstack-multinode/commit/589aeda9facb9fe91fcbaf5146df633266dadb0b)

## [31.1.0] - 2026-06-29

### Added

- Introduced scalability to the accepted terms wordlist, enabling smoother CI checks and improved developer experience by eliminating unnecessary spelling warnings during linting. [7f6f584a](https://github.com/electrocucaracha/openstack-multinode/commit/7f6f584a8d3c2576906c0b37056f360b590c4c37)

## [31.0.7] - 2026-06-29

### Changed

- Upgraded actions/cache and setup-go dependencies to their latest patch versions in workflow definitions to ensure the use of upstream bug fixes and improvements, reducing known issue risk without modifying workflow logic or configuration. [6544f373](https://github.com/electrocucaracha/openstack-multinode/commit/6544f373536c1d35084ab9e6339b6b2140b03d41)

## [31.0.6] - 2026-06-29

### Changed

- Updated the default OpenStack release to 2025.1 ensuring new deployments utilize the latest stable version by default without introducing breaking behavior or requiring migration. [046b82b1](https://github.com/electrocucaracha/openstack-multinode/commit/046b82b16f4098f9cd54d2a83a11f8491819d35a)

## [31.0.5] - 2026-06-29

### Changed

- Reorganized Kolla environment variables for improved readability and maintainability by grouping related settings together in a logical order without introducing any functional changes or breaking behavior. [b14ff733](https://github.com/electrocucaracha/openstack-multinode/commit/b14ff733521f773ca89cda08b92493bfd2dd1406)

## [31.0.4] - 2026-06-25

### Changed

- Upgraded OpenStack Kolla dependencies to ensure continued compatibility and functionality for users relying on these libraries. [89bf6141](https://github.com/electrocucaracha/openstack-multinode/commit/89bf61417bc396d980b7d69c08dacb771913b4ba)

## [31.0.3] - 2026-06-23

### Changed

- Stabilized Ansible inventory group layouts across aio, distributed, and noha sample inventories to accurately represent current service architectures and deployment best practices, improving maintainability for future updates and migrations. [ced67718](https://github.com/electrocucaracha/openstack-multinode/commit/ced6771867fcd84febbb554448d95dc2dc35870c)

## [31.0.2] - 2026-06-23

### Changed

- Streamlined the build configuration to ensure compatibility with the latest OpenStack and monitoring ecosystem by removing unused images and updating Prometheus exporters to their latest upstream versions. [3b3bab26](https://github.com/electrocucaracha/openstack-multinode/commit/3b3bab26f2368d2fccc1205a5ada0993dee1c36e)

## [31.0.1] - 2026-06-23

### Changed

- Stabilized OpenStack Kolla dependencies through upgrades to Ansible Core and cryptography libraries among others resulting in improved security and stability across various operating systems with no breaking behavior expected. [b0dcdb2f](https://github.com/electrocucaracha/openstack-multinode/commit/b0dcdb2f9f4b0deae2385735d1fe6a773db38114)

## [31.0.0] - 2026-06-23

### Removed

- BREAKING: Dropped support for OpenStack releases 2023.2, 2024.1, and 2024.2 to reduce maintenance overhead and ensure the project tracks only currently supported releases and platforms. [e00699e1](https://github.com/electrocucaracha/openstack-multinode/commit/e00699e132e360c167d4586042f22e5327cdc46e)

## [30.1.0] - 2026-06-23

### Added

- Enabled support for Ubuntu 24.04 and 26.04 in CI testing environments, replacing Rocky Linux boxes pending future updates, while ensuring compatibility with amd64 architecture and updating Debian 12 box versions and copyright year. [aac6b7a2](https://github.com/electrocucaracha/openstack-multinode/commit/aac6b7a27ed4424973ca7cee2257bce52a069941)

## [30.0.1] - 2026-06-23

### Fixed

- Resolved unnecessary npm installs and improved compatibility by directly checking for the prettier binary instead of relying on package list checks. [d855a2d6](https://github.com/electrocucaracha/openstack-multinode/commit/d855a2d6a316389343a898e99bf73e11915fc82e)

## [30.0.0] - 2026-06-23

### Removed

- Simplified YAML line comments in workflow files to conform to standard formatting conventions without introducing breaking changes or affecting functional behavior. [cf2fb371](https://github.com/electrocucaracha/openstack-multinode/commit/cf2fb371f7f4f26c1d0eec9365a8a101a4b9c10c)

## [29.2.1] - 2026-06-23

### Changed

- Stabilized GitHub Actions dependencies by updating them to their latest versions and improving the update process for automation reliability and CI dependency management. [ff8bd225](https://github.com/electrocucaracha/openstack-multinode/commit/ff8bd225260cf1a1815f5602670564c6bf1ed297)

## [29.2.0] - 2026-06-23

### Added

- Enabled automated code quality checks to enforce consistent formatting and catch common issues before commits, improving overall consistency and reliability by standardizing the codebase through linting of shell scripts with shellcheck and bashate, removal of trailing whitespace, validation of YAML files, and generation of AI-assisted commit messages. [dcd3b487](https://github.com/electrocucaracha/openstack-multinode/commit/dcd3b487dd902aad5398fb2e78bbc05d15851123)

## [29.1.0] - 2026-03-13

### Added

- Enabled support for super-linter reporter in GitHub actions through running scc tool and analyzing failed linter logs using AI inference to provide structured reasoning and proposed fixes without requiring any migration steps or affecting API or CLI contracts. [695fd65d](https://github.com/electrocucaracha/openstack-multinode/commit/695fd65d67bbb570359cff6c6965068fb7724132)

## [29.0.1] - 2026-03-13

### Changed

- Updated GitHub Actions versions across multiple workflows to reflect upgraded dependency versions affecting various tools including dive-action, trivy-action, actions/cache, actions/checkout, setup-go, reviewdog/action-misspell, and others. [2d68f106](https://github.com/electrocucaracha/openstack-multinode/commit/2d68f106c4442906b1055eb79bb8e07147eccdc7)

## [29.0.0] - 2026-03-13

### Removed

- Simplified the repository's configuration by eliminating an unused workflow that was no longer necessary. [2f4077fe](https://github.com/electrocucaracha/openstack-multinode/commit/2f4077fe2f2facf15edb40376f5b2a9ce4f95a7d)

## [28.0.4] - 2026-03-12

### Changed

- Suppressed unnecessary zizmor linting warnings about archived-uses and secrets-outside-env in GitHub Actions workflows allowing smoother execution without triggering errors. [40d304fc](https://github.com/electrocucaracha/openstack-multinode/commit/40d304fccd87aec739f8d6ab5570ef2e2649ff5f)

## [28.0.3] - 2026-03-12

### Changed

- Upgraded OpenStack Kolla dependencies to latest versions in multiple requirements files, including debian_11.txt, debian_12.txt, rocky_9.txt, ubuntu_22.txt, and others. [e58415c9](https://github.com/electrocucaracha/openstack-multinode/commit/e58415c9e8b71ad747fdecb8f19dfda5c0f3fcf5)

## [28.0.2] - 2026-01-31

### Fixed

- The scheduled job for verifying latest Vagrant Boxes now runs daily at 4am instead of 1am, updating the timing of automated verification tasks with no further action required from users or maintainers unless they relied on the specific 1am schedule. [976476c6](https://github.com/electrocucaracha/openstack-multinode/commit/976476c6aa9ae2f47f13f723ee19b4b1a1d627d0)

## [28.0.1] - 2025-12-30

### Changed

- Upgraded OpenStack Kolla dependencies to ensure builds of OpenStack environments utilize the latest library versions for oslo-i18n, oslo-utils, psutil, pyparsing, tzdata, urllib3, and stevedore. [d167f38c](https://github.com/electrocucaracha/openstack-multinode/commit/d167f38c63b371d4f62fdb30f96d3f10cd635d8a)

## [28.0.0] - 2025-11-16

### Removed

- Optimized Markdown formatting consistency across all projects by removing unnecessary linting issues that were no longer required due to the existing adherence to Semantic Line Breaks (SemBr) specification. [614adf33](https://github.com/electrocucaracha/openstack-multinode/commit/614adf33eabb1dc5c3d9bcc7f2ac10757859e28a)

## [27.6.1] - 2025-11-16

### Changed

- Upgraded OpenStack Kolla dependencies to newer versions of certifi, hvac, oslo-config, oslo-i18n, pbr, psutil, and wrapt, requiring potential migrations in projects using these versions. [7b1f6c34](https://github.com/electrocucaracha/openstack-multinode/commit/7b1f6c34d356b3844bf823ffa6bef243bd3ce9ed)

## [27.6.0] - 2025-11-16

### Added

- Enabled automated spelling corrections for users by updating the spell check word list to include new terms. [59b3e0a7](https://github.com/electrocucaracha/openstack-multinode/commit/59b3e0a76b7f57411d8194390cf1244c53ebdfe5)

## [27.5.5] - 2025-11-13

### Changed

- Semantic line breaks are now enabled in Markdown files by default, allowing for the automatic reformatting of documents without altering their rendered output or intended meaning. [7eb0ca29](https://github.com/electrocucaracha/openstack-multinode/commit/7eb0ca29cf89ccd41f698db2344088c87fbddeca)

## [27.5.4] - 2025-10-18

### Changed

- The GitHub workflows for spell checking were updated to resolve issues with Zizmor without introducing breaking behavior or requiring migration steps. [dd06e7b5](https://github.com/electrocucaracha/openstack-multinode/commit/dd06e7b51879488cd6659a95bc2b954ed0c60bf9)

## [27.5.3] - 2025-10-18

### Changed

- Updated the Markdown link checker action in the GitHub workflow to utilize improved functionality without introducing breaking behavior or requiring migration steps. [2c8c1a2e](https://github.com/electrocucaracha/openstack-multinode/commit/2c8c1a2e10e01f19aa02001d343f1cb2334dcde8)

## [27.5.2] - 2025-10-15

### Changed

- Upgraded dependencies for GitHub Actions and OpenStack Kolla to ensure compatibility and stability of workflows and libraries including certifi, charset-normalizer, cryptography, idna, and rich. [1b56f27b](https://github.com/electrocucaracha/openstack-multinode/commit/1b56f27b9492a74f8e3153256d795f155870f2f5)

## [27.5.1] - 2025-09-30

### Changed

- Upgraded OpenStack Kolla dependencies to newer versions, including cryptography from 46.0.1 to 46.0.2 and updating various GitHub workflows with the latest actions and dependencies, without introducing any breaking behavior or migration requirements. [51c868ed](https://github.com/electrocucaracha/openstack-multinode/commit/51c868ed3152f49d6ae1bf56c8e5f57627a24733)

## [27.5.0] - 2025-09-29

### Added

- Enabled more accurate code analysis and review tools by adding new terms to the GitHub Actions workflow wordlist. [afd2b4ce](https://github.com/electrocucaracha/openstack-multinode/commit/afd2b4ce3ace39aac7a6958ec4117663bf921492)

## [27.4.5] - 2025-09-29

### Changed

- Optimized linter configurations persist credentials by default for jobs using actions/checkout@v5.0.0 with the persist-credentials option, requiring updated permissions in workflows like on-demand.yml and update.yml. [715ce1e9](https://github.com/electrocucaracha/openstack-multinode/commit/715ce1e9b323c69928b3561a086ee1963b7e25b2)

## [27.4.4] - 2025-09-29

### Changed

- Updated OpenStack Kolla dependencies and GitHub Actions to ensure compatibility and security across various distributions and versions, potentially requiring migration steps or configuration adjustments in some cases. [c316da06](https://github.com/electrocucaracha/openstack-multinode/commit/c316da06dffb68f07d94cda5cb7a29231db96b38)

## [27.4.3] - 2025-09-29

### Changed

- Upgraded Python versions in various workflows and requirements files from 3.9 to 3.11 for Rocky 9, and from 3.10 to 3.12 for Ubuntu 24, requiring users running these distributions to update their Python versions accordingly with no breaking behavior or API changes introduced by this update. [9d64f5cd](https://github.com/electrocucaracha/openstack-multinode/commit/9d64f5cd8fb0a2146e5bd98d7a79568183dad3bd)

## [27.4.2] - 2025-08-19

### Changed

- Upgraded OpenStack Kolla dependencies to 18.7.0 for Debian 11 and 12, Ubuntu 22, and other platforms, affecting packages such as ansible-core, bcrypt, certifi, cryptography, and requests. [76202da5](https://github.com/electrocucaracha/openstack-multinode/commit/76202da52dc0a27ff4ffe968903b438f33a3def9)

## [27.4.1] - 2025-08-19

### Changed

- The GitHub workspace path in the update CI job was optimized to correctly handle various Linux distributions, ensuring compatibility and accurate dependency updates for OpenStack Kolla projects with no migration steps required. [1857dba7](https://github.com/electrocucaracha/openstack-multinode/commit/1857dba7048768a34621e15274830611f3d47451)

## [27.4.0] - 2025-08-12

### Added

- Enabled users to specify a default branch for super-linter checks in the GitHub workflow without introducing breaking behavior and requiring no migration steps. [3feaef3d](https://github.com/electrocucaracha/openstack-multinode/commit/3feaef3dfff6a2dd525b188bf5feda354f64252c)

## [27.3.21] - 2025-08-12

### Changed

- Upgraded OpenStack Kolla dependencies and GitHub Actions versions to ensure compatibility and maintain the latest features, potentially requiring re-running some workflows due to version updates but introducing no breaking behavior or security risks. [e8b2c0d8](https://github.com/electrocucaracha/openstack-multinode/commit/e8b2c0d82aeaa9a07eaa2a44cb2097084f92dd1d)

## [27.3.20] - 2025-08-07

### Changed

- Upgraded OpenStack Kolla dependencies to certifi 2025.8.3 and cryptography 45.0.6 in requirements files for Rocky 9. [164da168](https://github.com/electrocucaracha/openstack-multinode/commit/164da168cc36ae3c3f0ba4c58bcadec936982c74)

## [27.3.19] - 2025-07-24

### Changed

- Simplified variable naming across configuration files to improve consistency in deployment scripts for All-in-One and No High Availability setups without impacting migration requirements or API/CLI contracts. [059f91ee](https://github.com/electrocucaracha/openstack-multinode/commit/059f91eecaea51a7522f73d3331c8186a0265446)

## [27.3.18] - 2025-07-24

### Changed

- Hardened security by upgrading OpenStack Kolla dependencies and updating GitHub Actions to newer versions of super-linter and setup-uv actions, potentially fixing vulnerabilities in outdated libraries without introducing breaking behavior or migration requirements. [b97be99d](https://github.com/electrocucaracha/openstack-multinode/commit/b97be99d6514aea4cf85613629752f55511dd17d)

## [27.3.17] - 2025-07-07

### Changed

- Updated supported vagrant boxes for Rocky Linux to use new repository URL, requiring existing configurations to be updated accordingly without affecting the API contract or introducing security concerns. [a1d13f6e](https://github.com/electrocucaracha/openstack-multinode/commit/a1d13f6ebec187106781f8c28514dcea5c62613a)

## [27.3.16] - 2025-07-07

### Changed

- Normalized indentation formatting across various scripts to ensure consistent coding standards and improve code maintainability without introducing any breaking behavior or requiring migration. [535e6a9b](https://github.com/electrocucaracha/openstack-multinode/commit/535e6a9bbde2a660fe8e03fd15998a91786b92fc)

## [27.3.15] - 2025-07-07

### Changed

- Upgraded OpenStack Kolla dependencies to ensure compatibility and stability in the undercloud setup. [d1ab0ae7](https://github.com/electrocucaracha/openstack-multinode/commit/d1ab0ae7339cbb1dc9a799f4b9e5232d49d75b0d)

## [27.3.14] - 2025-07-07

### Changed

- Upgraded GitHub Actions and dependencies for OpenStack Kolla to ensure continued support and stability of the system without introducing breaking behavior or requiring migration steps. [bc1d1db1](https://github.com/electrocucaracha/openstack-multinode/commit/bc1d1db197d96d2189588636fbe8202c487fc09c)

## [27.3.13] - 2025-07-07

### Changed

- Upgraded dependencies for GitHub Actions and OpenStack Kolla to newer versions, introducing no breaking behavior but potentially affecting the Docker image layer contents and Trivy vulnerability scanner in workflows. [438420d0](https://github.com/electrocucaracha/openstack-multinode/commit/438420d0862dd0325a1c7b67f98e1c3862da8a49)

## [27.3.12] - 2025-07-07

### Changed

- Updated linter configurations to use the `.editorconfig-checker.json` file instead of `.editorconfig`, requiring users to update their linting tools and workflows accordingly. [5287f5a1](https://github.com/electrocucaracha/openstack-multinode/commit/5287f5a15961ee08cec84ff6d25489f07f54f476)

## [27.3.11] - 2025-07-07

### Changed

- kolla builds and updates its images in accordance with Epoxy release support. [afc8cf00](https://github.com/electrocucaracha/openstack-multinode/commit/afc8cf0044cd908f0686c021dc36abce1acfef8c)

## [27.3.10] - 2025-04-11

### Changed

- Optimized package installations for kolla-build and docker-squash packages to utilize uv instead of pip, requiring users to have uv installed on their system if it is not already present. [9f54e617](https://github.com/electrocucaracha/openstack-multinode/commit/9f54e61741688fdb58444affbee7e37da2395a43)

## [27.3.9] - 2025-04-09

### Changed

- Upgraded the linter version used in the GitHub Actions workflow from 7 to 7.3.0. [2c490b82](https://github.com/electrocucaracha/openstack-multinode/commit/2c490b824a2a918e280b0ad589e44841b484b0f5)

## [27.3.8] - 2025-03-22

### Changed

- Modernized OpenStack Kolla dependencies and GitHub Actions versions to ensure compatibility and maintain the integrity of automated workflows for users relying on these dependencies in their projects. [348c485d](https://github.com/electrocucaracha/openstack-multinode/commit/348c485dcff90124943200f094b95ac75dd8aa6f)

## [27.3.7] - 2025-03-18

### Changed

- Upgraded GitHub Actions and OpenStack Kolla dependencies to their latest versions, enhancing the project's dependency management system without introducing any breaking changes. [36734c42](https://github.com/electrocucaracha/openstack-multinode/commit/36734c4208ec39d859b9a332e56309f107835d37)

## [27.3.6] - 2025-03-14

### Changed

- Dependencies are now managed and compiled in CI workflows using the pyproject.toml file instead of individual version files. [f578465f](https://github.com/electrocucaracha/openstack-multinode/commit/f578465f97c56a796f857a22e98d2eab089a3e0e)

## [27.3.5] - 2025-03-14

### Changed

- Optimized requirements generation by switching from pip-compile to uv, which may require users to update their workflows and install the new dependency. [4e243810](https://github.com/electrocucaracha/openstack-multinode/commit/4e2438100d2a5140aaeb85d9ec1f8ff9b913f5ee)

## [27.3.4] - 2025-03-14

### Changed

- Optimized installation and update processes for OpenStack services and dependencies by replacing `pip` with the `-m pip` command to ensure compatibility with Python 3.x's module naming conventions without introducing any breaking behavior or migration requirements. [77169aff](https://github.com/electrocucaracha/openstack-multinode/commit/77169aff86f85cc9630233ab3058b9463bbe1e45)

## [27.3.3] - 2025-02-14

### Changed

- Updated OpenStack Kolla dependencies and GitHub Actions configurations to ensure compatibility with the latest OpenStack releases without introducing any breaking behavior. [24859d3e](https://github.com/electrocucaracha/openstack-multinode/commit/24859d3e948765837e7ddb696a798c104e4fd462)

## [27.3.2] - 2025-02-13

### Changed

- Modernized GitHub Actions dependencies to include updated OpenStack Kolla and cryptography versions, potentially requiring migration adjustments for users running these packages. [ea2d1594](https://github.com/electrocucaracha/openstack-multinode/commit/ea2d1594ab1947c691d4f1a049f23310ae41894d)

## [27.3.1] - 2025-02-04

### Changed

- Upgraded OpenStack Kolla dependencies to the latest versions in GitHub Actions workflows and requirements files for different operating systems. [b53298d6](https://github.com/electrocucaracha/openstack-multinode/commit/b53298d63252ec299602cf5d91dd2276fff7b85b)

## [27.3.0] - 2025-02-04

### Added

- Enabled authentication for GitHub workflows using WORKFLOW_TOKEN secret token instead of personal access tokens with no breaking changes required for existing configurations. [7267acf4](https://github.com/electrocucaracha/openstack-multinode/commit/7267acf43b3e4dde7405905f5b88c300edb51681)

## [27.2.7] - 2025-01-22

### Changed

- Enabled support for Debian 12 in testing environments without requiring additional configuration or migration steps. [cd1ffbb3](https://github.com/electrocucaracha/openstack-multinode/commit/cd1ffbb3e45c0c48683ec9301b2aef1afa76c0f5)

## [27.2.6] - 2025-01-22

### Changed

- Upgraded OpenStack Kolla dependencies to ensure compatibility with the latest Python versions, requiring users who rely on these dependencies for their projects to update their requirements accordingly. [c69a55b9](https://github.com/electrocucaracha/openstack-multinode/commit/c69a55b972ac8b2eb03ddf828c6a3298aad886d4)

## [27.2.5] - 2025-01-22

### Changed

- Updated the supported operating systems matrix to reflect Debian 11 support for versions 2023.1, 2023.2, and 2024.1 while removing it from version 2024.2 with no migration steps or breaking behavior required. [0ab83acf](https://github.com/electrocucaracha/openstack-multinode/commit/0ab83acfffd8aa67de9d4a7da62650e4432fd7f9)

## [27.2.4] - 2025-01-10

### Changed

- The supported distributions for Rocky Linux 9 have been updated to use the SATA Controller instead of the IDE Controller in the VB controller configuration, which may require users to update their virtual machine configurations if they were relying on the previous setting. [be78a9f6](https://github.com/electrocucaracha/openstack-multinode/commit/be78a9f67901957291d0241cf04c6d84d7fbddde)

## [27.2.3] - 2025-01-10

### Changed

- Updated dependencies for various operating systems to ensure compatibility and security. [0a2f1a3a](https://github.com/electrocucaracha/openstack-multinode/commit/0a2f1a3a11bac3aa6c18bae55dcd1219a363be07)

## [27.2.2] - 2025-01-10

### Changed

- Updated the pinned Vagrant box for Rocky Linux to use the community version, potentially breaking existing builds that relied on the previously used version and requiring users with custom configurations or dependencies tied to the original version to update their setups accordingly. [13ea7295](https://github.com/electrocucaracha/openstack-multinode/commit/13ea7295eb90846bbc86dca72b12c5595b1787a5)

## [27.2.1] - 2025-01-10

### Changed

- Upgraded GH action versions to improve performance and security for tasks like code checkout, caching, vulnerability scanning, and more, without introducing breaking changes or requiring migration efforts. [3caccce7](https://github.com/electrocucaracha/openstack-multinode/commit/3caccce759e7b50e446bd29e0d4d4697d1ab2bd3)

## [27.2.0] - 2025-01-10

### Added

- Enabled GitHub Action linter configuration to enforce specific rules for self-hosted runners, labeling them with the "vm-self-hosted" label without introducing breaking behavior and requiring migration steps. [5625b80a](https://github.com/electrocucaracha/openstack-multinode/commit/5625b80a3e7f06b860aef050a965c57cb4c077e3)

## [27.1.4] - 2025-01-10

### Changed

- Updated Kolla's configuration to support building images for the Dalmatian release, requiring users who build images for this release to update their configuration accordingly. [339e1e98](https://github.com/electrocucaracha/openstack-multinode/commit/339e1e98a6222ad67f25b52de6fcd4c5abed8aaf)

## [27.1.3] - 2025-01-10

### Changed

- Migrated workflows that previously ran on macOS-12 to self-hosted runners. [79164df4](https://github.com/electrocucaracha/openstack-multinode/commit/79164df446a1490678578c34e90b71b4c7709a73)

## [27.1.2] - 2024-12-12

### Changed

- Simplified LVM group creation for users managing Cinder volumes by removing an empty volume check and streamlining the `vgcreate` command to reduce potential errors without introducing any breaking behavior or migration requirements. [6c238450](https://github.com/electrocucaracha/openstack-multinode/commit/6c238450e0bc1ad72fa3d4d63ea0c08a99d15021)

## [27.1.1] - 2024-10-11

### Changed

- Tox installation now requires system packages to be installed first by default which may break existing workflows that relied on the previous behavior. [e6fc68c8](https://github.com/electrocucaracha/openstack-multinode/commit/e6fc68c85f2533c28d52e356846743ccec579736)

## [27.1.0] - 2024-10-11

### Added

- Enabled automatic reformatting of code throughout the repository on exit if necessary, ensuring consistent formatting without requiring manual intervention. [a1ced729](https://github.com/electrocucaracha/openstack-multinode/commit/a1ced729a1d1faa7a07595f452e4ab2daac6100b)

## [27.0.3] - 2024-10-11

### Changed

- The super-linter Docker images now utilize the new GitHub Container Registry URL without introducing any breaking behavior or requiring migration steps. [2cb79c62](https://github.com/electrocucaracha/openstack-multinode/commit/2cb79c62ad298a1f87462752311fae8da274661e)

## [27.0.2] - 2024-10-07

### Changed

- Enabled collection of VBox HW metrics on failures in CI workflows, providing valuable information for debugging and troubleshooting across all affected VirtualBox environments. [dca6d45e](https://github.com/electrocucaracha/openstack-multinode/commit/dca6d45eb4f3bc659af1b8aeb432335694966985)

## [27.0.1] - 2024-10-07

### Changed

- Simplified GitHub condition filtering in workflows to correctly filter based on pull request review approval status without introducing breaking behavior or security risks. [2418f392](https://github.com/electrocucaracha/openstack-multinode/commit/2418f392beddff49f79eb6bea06135e354f50c9e)

## [27.0.0] - 2024-10-01

### Removed

- Eliminated unnecessary artifact uploads to GitHub by no longer including an upload action in the Docker image GitHub Action. [75d0cb83](https://github.com/electrocucaracha/openstack-multinode/commit/75d0cb83ed30df57bc20881b40c17c3a33c1f887)

## [26.7.0] - 2024-10-01

### Added

- Enabled write access to security events in SARIF GitHub permissions for uploading code analysis results without requiring any migration steps and preserving the unchanged API contract. [e8c2700d](https://github.com/electrocucaracha/openstack-multinode/commit/e8c2700d4410e26e0fc1b45a200af6eec4f7cfe9)

## [26.6.5] - 2024-10-01

### Changed

- Optimized linting configurations to improve code consistency and readability throughout various scripts without introducing breaking behavior or requiring migration efforts. [9c29186b](https://github.com/electrocucaracha/openstack-multinode/commit/9c29186b2c92575e09b7b720fa99f7c2bfd907cd)

## [26.6.4] - 2024-10-01

### Changed

- Updated workflows to use the latest action versions, ensuring compatibility and maintaining up-to-date functionality for checkout, vagrant setup, create PR actions, and other affected processes. [1707315d](https://github.com/electrocucaracha/openstack-multinode/commit/1707315dd3b71982e1c201a5db43de6213b872ec)

## [26.6.3] - 2024-10-01

### Changed

- Enabled Trivy tool for Docker image scanning, replacing Clair and requiring configuration updates to utilize its output format for uploading scan results to the GitHub Security tab. [8fbbf042](https://github.com/electrocucaracha/openstack-multinode/commit/8fbbf0423d7a585b266fd18bc8cff6f35bc4534b)

## [26.6.2] - 2024-09-30

### Changed

- Optimized Debian system installations now automatically install required dependencies for users running the `node.sh` script. [7b2f2bac](https://github.com/electrocucaracha/openstack-multinode/commit/7b2f2bace9fe5225b293507a76238c5fb4366188)

## [26.6.1] - 2024-09-30

### Changed

- Upgraded OpenStack Kolla dependencies to ensure compatibility across various Debian and Ubuntu versions. [6e142255](https://github.com/electrocucaracha/openstack-multinode/commit/6e142255819de3fc024c9604d4285a4dbb3c0b51)

## [26.6.0] - 2024-09-30

### Added

- Enabled create-pr-action to push code and create pull requests within various GitHub workflows without introducing breaking behavior or migration requirements. [dd56a51b](https://github.com/electrocucaracha/openstack-multinode/commit/dd56a51b9105faef87216b38f1add7294f30325b)

## [26.5.0] - 2024-09-30

### Added

- Enabled shfmt validation for syntax error checking in the linter workflow, allowing users to enforce shell scripting standards without any breaking behavior or migration requirements necessary. [9c2634a9](https://github.com/electrocucaracha/openstack-multinode/commit/9c2634a92da1ffce96fbdcf9c5a5557473bc1dec)

## [26.4.0] - 2024-09-30

### Added

- Enabled flexibility in automated updates by disabling editorconfig checker in update distros script without introducing any breaking changes or modifying API contracts. [78fe180b](https://github.com/electrocucaracha/openstack-multinode/commit/78fe180b6fead4e13d7c56480d4581c547e4269d)

## [26.3.15] - 2024-09-30

### Changed

- Streamlined the supported distributions by deprecating yoga and zed releases in favor of newer versions without introducing any breaking behavior or migration requirements for users. [2e410a24](https://github.com/electrocucaracha/openstack-multinode/commit/2e410a240857a9c3d8e58751f441aee9e804b443)

## [26.3.14] - 2024-09-30

### Changed

- Expanded HTTP status codes for server health monitoring to include forbidden responses, allowing developers to monitor servers that block requests more comprehensively without introducing any breaking behavior or requiring migration steps. [cf5995c3](https://github.com/electrocucaracha/openstack-multinode/commit/cf5995c3cc1ab36517c50a2ed544b022c8bacd5d)

## [26.3.13] - 2024-09-30

### Changed

- Updated linter configuration to properly execute checks without permission errors in GitHub Actions workflows. [4244c963](https://github.com/electrocucaracha/openstack-multinode/commit/4244c963f5d16258fdb699007d8cd849443ce963)

## [26.3.12] - 2024-09-30

### Changed

- Updated editorconfig format to maintain consistency and accuracy in project configurations and scripts affecting various files including distros_supported.yml and modifying the vercmp() function in commons_spec.sh and the _get_kolla_actions() function in undercloud_spec.sh. [f4c40bb3](https://github.com/electrocucaracha/openstack-multinode/commit/f4c40bb33cede9030bd6f56273922d8d49096026)

## [26.3.11] - 2024-09-30

### Changed

- The project now enforces consistent coding style across different editors by specifying indentation size and ignoring certain directories. [8467bfbc](https://github.com/electrocucaracha/openstack-multinode/commit/8467bfbc42bf86104b94839ae4556b3ff8b39685)

## [26.3.10] - 2024-09-30

### Changed

- The contributors link now uses an alternate text format instead of an image link without introducing any breaking behavior or security concerns. [da19c46b](https://github.com/electrocucaracha/openstack-multinode/commit/da19c46b36a56475b2cc8fbccd99ada5fb165725)

## [26.3.9] - 2024-09-30

### Changed

- Prettier is now used for formatting instead of Makefile's manual usage of `yamlfmt` and `shfmt`, resulting in improved code consistency and readability without introducing breaking behavior or requiring migration. [65a4ff0f](https://github.com/electrocucaracha/openstack-multinode/commit/65a4ff0fe55fb9fa21b33cd1bed88dbd167cb3f0)

## [26.3.8] - 2024-09-30

### Changed

- Images are now dynamically tagged in the Docker registry using Git SHA during build, replacing static tags like 'latest', and users must update their registries accordingly to avoid breaking builds that rely on specific versions. [ede07c92](https://github.com/electrocucaracha/openstack-multinode/commit/ede07c92ca6feaf64141fd8f42d6b7ae81720ea4)

## [26.3.7] - 2024-09-30

### Changed

- Resolved shellcheck issues in the GitHub Actions workflow for OnDemand AIO to prevent command execution errors without requiring any additional migration steps or changes to security settings. [b5843131](https://github.com/electrocucaracha/openstack-multinode/commit/b58431311f3eaf831ea286c0193336688c1c6795)

## [26.3.6] - 2024-09-30

### Changed

- Enabled GitHub Actions to include descriptions for Docker image analysis, enhancing user understanding of their functionality and providing clarity on what these actions accomplish. [4c11cae6](https://github.com/electrocucaracha/openstack-multinode/commit/4c11cae6cd445d0ebaaaf3c28473f4bbac439c69)

## [26.3.5] - 2024-09-30

### Changed

- GitHub Actions workflows now utilize read-only permissions by default thereby hardening the environment for automated actions to run without modifying repository contents. [f404eae6](https://github.com/electrocucaracha/openstack-multinode/commit/f404eae651d6bb6927ba8598f5ca0f46650e5a0d)

## [26.3.4] - 2024-09-30

### Changed

- Test scripts are now executed with more permissive permissions due to updated file modes from 644 to 755. [19cc8d72](https://github.com/electrocucaracha/openstack-multinode/commit/19cc8d72f4dea358b3642c917c6ca48f0e1da4f7)

## [26.3.3] - 2024-09-28

### Changed

- Updated all GitHub Actions versions in workflows to reference the latest available tags instead of specific commit hashes. [1035ebdd](https://github.com/electrocucaracha/openstack-multinode/commit/1035ebdd8385ad5862740a74a910d2284fa13610)

## [26.3.2] - 2024-09-28

### Changed

- Enabled analysis of security and size of Docker images through Clair GH action which now replaces dive-action in build.yml workflows without introducing breaking behavior. [0f42ec02](https://github.com/electrocucaracha/openstack-multinode/commit/0f42ec02d14570981a0995474949fdcfa748c18a)

## [26.3.1] - 2024-09-27

### Changed

- Enabled detailed layer contents inspection for debugging and optimization efforts through integration of Dive actions on Keystone built images in CI workflows. [11560cee](https://github.com/electrocucaracha/openstack-multinode/commit/11560cee0d712746bc46733b6543625a991b8316)

## [26.3.0] - 2024-09-03

### Added

- Enforced config drive configuration for users relying on this feature, requiring manual intervention from maintainers to ensure compatibility with existing configurations. [052aa5c9](https://github.com/electrocucaracha/openstack-multinode/commit/052aa5c93d6a4e23b190edd8f6120a74c18381b4)

## [26.2.0] - 2024-09-03

### Added

- Enabled installation of kernel modules required by Cinder LVM backend for users on Ubuntu and Debian systems, ensuring the feature is available without issues if the "linux-modules-extra" package with the current kernel version is installed during setup. [e7abec2e](https://github.com/electrocucaracha/openstack-multinode/commit/e7abec2eabc1a902826b52881a657f945b1ad19a)

## [26.1.3] - 2024-09-03

### Changed

- Workflows that relied on the latest version of GitHub Actions now require manual review and updates due to changes in action versions in `.github/workflows/` files. [33dfd1ed](https://github.com/electrocucaracha/openstack-multinode/commit/33dfd1ed898bab041cbca4fb0a5943819eefe068)

## [26.1.2] - 2024-08-21

### Changed

- Enabled cinder-related functionality for testing in AIO CI tasks without introducing any breaking behavior or migration requirements. [6ab78ae9](https://github.com/electrocucaracha/openstack-multinode/commit/6ab78ae91f881771db6d0c2b364af0f6af3eea4d)

## [26.1.1] - 2024-08-21

### Changed

- The default volume type configuration for Cinder services has been updated to utilize the LVM-1 backend instead of iSCSI. [b22a8f60](https://github.com/electrocucaracha/openstack-multinode/commit/b22a8f60c708f4b6242d304737f4371ba0967463)

## [26.1.0] - 2024-08-21

### Added

- Enabled users to run the noha sample cluster setup without encountering issues related to Raspberry Pi hardware by disabling the link check for this specific platform. [a745e01e](https://github.com/electrocucaracha/openstack-multinode/commit/a745e01ecf6ae48d5a8e01cbb40bc397c90a122f)

## [26.0.3] - 2024-08-21

### Changed

- Upgraded OpenStack Kolla dependencies to newer versions, ensuring compatibility across various operating systems and Ansible configurations. [8bb154c0](https://github.com/electrocucaracha/openstack-multinode/commit/8bb154c0f79f97aa795fbff933935bd76fb9d0b9)

## [26.0.2] - 2024-08-21

### Changed

- The installation process now automatically checks for and installs the latest dependencies if necessary to ensure users have the most up-to-date packages. [7b9eb433](https://github.com/electrocucaracha/openstack-multinode/commit/7b9eb4332996145ada20842ec279edcc1b50bc0f)

## [26.0.1] - 2024-08-21

### Changed

- Optimized cinder volume creation and management by removing unnecessary pvcreate command and enhancing vgs functionality to display volume group information. [75349a17](https://github.com/electrocucaracha/openstack-multinode/commit/75349a170baddff237592627746f5a77fcbbf81b)

## [26.0.0] - 2024-08-21

### Removed

- Eliminated reliance on non-standard `awk` command in NoHA Vagrant setup by replacing it with more portable alternatives, resulting in no observable impact for developers or operators and no breaking behavior changes. [4e8c4385](https://github.com/electrocucaracha/openstack-multinode/commit/4e8c438525c3e9c18d136ef8007286da0842e048)

## [25.0.1] - 2024-08-21

### Changed

- Updated lvm filter instructions to dynamically configure the global_filter in /etc/lvm/lvm.conf based on available physical volumes eliminating the need for manual storage configuration updates and improving system flexibility. [4b33a40d](https://github.com/electrocucaracha/openstack-multinode/commit/4b33a40ddcaf3cf3873def498bb99db19c107a2e)

## [25.0.0] - 2024-08-16

### Removed

- Simplified setup process by removing cloud-init package from all OS nodes, requiring manual purge on Ubuntu and Debian systems after installation. [fe53565c](https://github.com/electrocucaracha/openstack-multinode/commit/fe53565cd1a071e1bf2dbbd8892ad853b518668a)

## [24.4.0] - 2024-08-16

### Added

- LVM scanning tools are now configured to only scan devices containing the cinder-volumes volume group, avoiding non-cinder volumes, and this change may require adjustments in external scripts that rely on this configuration. [b4dc9bca](https://github.com/electrocucaracha/openstack-multinode/commit/b4dc9bca1b4f8bba91681289ffcd548575947e9c)

## [24.3.1] - 2024-08-15

### Changed

- Updated the rabbitmq PR link to point to the correct location allowing users to access the latest information on rabbitmq configuration without introducing any breaking behavior or requiring migration steps. [de2ff298](https://github.com/electrocucaracha/openstack-multinode/commit/de2ff298c36aef8c40deedf51c0438b34c568c85)

## [24.3.0] - 2024-08-13

### Added

- Enabled users to configure their setup for noha inventory by introducing additional compute resources which must be updated in the tail.ini configuration with new resource names: network, compute, storage, and monitoring. [5c5bbd3a](https://github.com/electrocucaracha/openstack-multinode/commit/5c5bbd3a2f8b7fd0daf78a122cc394efca4ef39b)

## [24.2.9] - 2024-07-15

### Changed

- Updated the reviewdog/action-misspell action to version 1.23.0, introducing minor enhancements in spell checking behavior without breaking any existing functionality or requiring migration efforts. [b5098b5c](https://github.com/electrocucaracha/openstack-multinode/commit/b5098b5ca0a4f3df3113e911fecb9f5f87d0bdbe)

## [24.2.8] - 2024-07-11

### Changed

- Updated the Go setup action in the linter workflow to version 5.0.2, which includes minor bug fixes and new features without introducing breaking changes or requiring migration steps. [29cefbf2](https://github.com/electrocucaracha/openstack-multinode/commit/29cefbf24476f06600987f87c73827c5a39775d7)

## [24.2.7] - 2024-07-08

### Changed

- Modernized spell checking functionality by updating reviewdog/action-misspell to version 1.22.0, introducing no breaking changes and maintaining compatibility with existing API and CLI contracts. [e0c72594](https://github.com/electrocucaracha/openstack-multinode/commit/e0c72594678b8b109152733401ebef6c1659f93c)

## [24.2.6] - 2024-06-24

### Changed

- Updated reviewdog/action-misspell to version 1.21.0, enabling the latest spell checking functionality in .github/workflows/spell.yml workflows with no breaking changes required. [1fd9cd95](https://github.com/electrocucaracha/openstack-multinode/commit/1fd9cd9500bf88f08260f53220089abcbe4476bd)

## [24.2.5] - 2024-06-18

### Changed

- Upgraded reviewdog/action-misspell to version 1.20.0, introducing no breaking behavior or API changes that require migration steps in workflows using this action. [3fad8bae](https://github.com/electrocucaracha/openstack-multinode/commit/3fad8baedcc5ec86fefc0d4a0e608b3a9451336f)

## [24.2.4] - 2024-06-13

### Changed

- Updated the actions/checkout dependency to version 4.1.7, which likely stabilizes the checkout process for multiple workflows with possible bug fixes and improvements in this minor patch update. [1341b9ab](https://github.com/electrocucaracha/openstack-multinode/commit/1341b9ab0cab0391fb751b0f8ef65a1b5d84ecca)

## [24.2.3] - 2024-06-10

### Changed

- Updated reviewdog/action-misspell to version 1.19.0, enabling users of spell checking in GitHub workflows to leverage the latest minor version without requiring migration steps. [7d38c114](https://github.com/electrocucaracha/openstack-multinode/commit/7d38c1141110d95af962ee3eab500976cebfb60c)

## [24.2.2] - 2024-06-05

### Changed

- Updated the reviewdog/action-misspell dependency to version 1.18.0, maintaining compatibility and requiring no migration steps for existing configurations. [467118a1](https://github.com/electrocucaracha/openstack-multinode/commit/467118a1a3f3484124f3f8ac21291c38f223dd07)

## [24.2.1] - 2024-05-29

### Changed

- Optimized cinder volume creation on AIO by enabling fake LVMs, requiring users to update their Vagrant configurations accordingly. [0a62a1fa](https://github.com/electrocucaracha/openstack-multinode/commit/0a62a1fa4dece17d4648b64e655d5b2e18129f55)

## [24.2.0] - 2024-05-29

### Added

- Optimized cinder volume initialization by ensuring volumes are always empty and ready for use before formatting. [12c6ed63](https://github.com/electrocucaracha/openstack-multinode/commit/12c6ed633d93183b4af8c603b79b619eaceaf069)

## [24.1.12] - 2024-05-22

### Changed

- Enabled support for the Caracal release by updating openstack_release to 2024.1 in defaults.env and .github/workflows/update.yml, potentially breaking functionality if not properly migrated. [c000f8a7](https://github.com/electrocucaracha/openstack-multinode/commit/c000f8a7e9bfe53385436481a4c813134d26161a)

## [24.1.11] - 2024-05-17

### Changed

- Updated actions/checkout to version 4.1.6, which is a minor patch update that does not introduce breaking behavior or migration requirements and has no observable impact on workflows using the checkout action. [b313e109](https://github.com/electrocucaracha/openstack-multinode/commit/b313e109b37fa33cffc1516ff4202340bb1e1a99)

## [24.1.10] - 2024-05-07

### Changed

- Updated the dependency on actions/checkout to version 4.1.5, ensuring compatibility with the latest version of this action without introducing any breaking behavior, API changes, security impact, or config schema modifications. [31dd8464](https://github.com/electrocucaracha/openstack-multinode/commit/31dd846447b233acd0cfb92c9fd9b91be14ffe36)

## [24.1.9] - 2024-05-06

### Changed

- Updated dictionary definitions and OpenStack Kolla dependencies to ensure compatibility across various operating systems including Debian 11, Rocky 9, Ubuntu 20, and Ubuntu 22 as well as specific project directories like yoga and zed. [5e53d451](https://github.com/electrocucaracha/openstack-multinode/commit/5e53d451a2a9b9c53477818d273d92866158d150)

## [24.1.8] - 2024-05-03

### Changed

- Updated the actions/setup-go dependency to version 5.0.1, which includes minor setup behavior improvements and bug fixes from the previous release. [74ebe189](https://github.com/electrocucaracha/openstack-multinode/commit/74ebe189127a9bf7b227f66d1a6234bebda04fc1)

## [24.1.7] - 2024-04-26

### Changed

- Enabled detailed code analysis and metrics for users through the addition of SCC badges and GitHub actions. [bee18806](https://github.com/electrocucaracha/openstack-multinode/commit/bee18806324e8cb22ec0e098df1df88c5311c1ff)

## [24.1.6] - 2024-04-25

### Changed

- Updated actions/checkout to version 4.1.4 for access to the latest features and bug fixes without introducing any breaking behavior or API contract changes. [762a3b50](https://github.com/electrocucaracha/openstack-multinode/commit/762a3b50d1abd68e7a667dc46ed26a56f27350ae)

## [24.1.5] - 2024-04-22

### Changed

- Updated actions/checkout to version 4.1.3, which may include bug fixes and performance improvements without requiring any migration steps or breaking behavior. [c8aa569e](https://github.com/electrocucaracha/openstack-multinode/commit/c8aa569ea4d1638a7ed1a41ff1ff0d571de66588)

## [24.1.4] - 2024-03-28

### Changed

- Updated reviewdog/action-misspell to version 1.17.0, which may require re-running existing spell check jobs for continued functionality. [afea6926](https://github.com/electrocucaracha/openstack-multinode/commit/afea6926ae3e50cdc8f783974624c34b51acd061)

## [24.1.3] - 2024-03-20

### Changed

- Updated the actions/cache dependency to version 4.0.2, which includes minor improvements and no breaking behavior or API changes. [a32c7966](https://github.com/electrocucaracha/openstack-multinode/commit/a32c7966a54641415f198b12c683e1b2e9b503a0)

## [24.1.2] - 2024-03-15

### Changed

- Upgraded OpenStack Kolla dependencies to newer versions of cryptography, oslo-config, oslo-i18n, oslo-utils, and stevedore packages, which may impact users relying on these dependencies for their OpenStack deployments. [e9d10305](https://github.com/electrocucaracha/openstack-multinode/commit/e9d10305adf30b913f6f916b4a1294cbd6a3e914)

## [24.1.1] - 2024-03-15

### Changed

- Optimized YAML formatting is now enabled for various workflows that lint or format YAML files, including the .github/workflows/linter.yml configuration and other affected jobs. [02aa7f0e](https://github.com/electrocucaracha/openstack-multinode/commit/02aa7f0ea5bd76e69568e07e317c72f857e427fc)

## [24.1.0] - 2024-03-15

### Added

- Enabled UTF-8 encoding support in Debian environments by setting LC_ALL to C.UTF-8 for correct character encoding and locale handling compatibility. [4467d22e](https://github.com/electrocucaracha/openstack-multinode/commit/4467d22e58fec935c6c47f4b4abf1d635095ff1c)

## [24.0.0] - 2024-03-15

### Removed

- Simplified the upgrade script to no longer enable xtrace by default in debug mode, eliminating unnecessary tracing and leaving the API and CLI contract unaffected. [9680f04f](https://github.com/electrocucaracha/openstack-multinode/commit/9680f04f1534f842646b6832734e8a9d7db6b571)

## [23.4.1] - 2024-03-15

### Changed

- Resolved outdated link references in README files to improve sample deployment guide reliability without affecting API or CLI contracts, config schema, security, or migration requirements. [6eb86fe7](https://github.com/electrocucaracha/openstack-multinode/commit/6eb86fe7d67f6d8a52a247d15da10232252f763a)

## [23.4.0] - 2024-03-14

### Added

- Enabled support for deploying OpenStack on Google Cloud in the AIO sample by introducing new environment variables and provider-specific settings in the Vagrantfile. [67b50cfa](https://github.com/electrocucaracha/openstack-multinode/commit/67b50cfa335c63db9df56db948b3eec74f6ce1b7)

## [23.3.1] - 2024-03-14

### Changed

- Updated the list of supported distributions to include GCE images, which are now used for testing and development in place of previous options. [0b7f4c9c](https://github.com/electrocucaracha/openstack-multinode/commit/0b7f4c9c4b45774b64cb0d86de74eb7f0b6b191f)

## [23.3.0] - 2024-03-14

### Added

- Enabled automatic installation of fdisk on affected Linux distributions to ensure partition management functionality remains available. [22e802cf](https://github.com/electrocucaracha/openstack-multinode/commit/22e802cfbf3cad619e2bf6e5645707229f3a9785)

## [23.2.7] - 2024-03-13

### Changed

- Updated the actions/checkout dependency to version 4.1.2, which stabilizes various workflows that rely on this action for checking out code without introducing any breaking behavior or API changes. [278c85d2](https://github.com/electrocucaracha/openstack-multinode/commit/278c85d263c398511d6fbe144dce896872feb3dd)

## [23.2.6] - 2024-03-05

### Changed

- Updated the reviewdog/action-misspell dependency to version 1.16.0, introducing no breaking behavior and preserving the API and CLI contract, with no security impact but potentially affecting users relying on the spell-checking feature in their workflows. [c0791c39](https://github.com/electrocucaracha/openstack-multinode/commit/c0791c39ece245abde42fe189d250f41a5e4de56)

## [23.2.5] - 2024-03-01

### Changed

- Updated the actions/cache dependency to version 4.0.1, which may require migration steps in workflows using this action. [d1a0d8ef](https://github.com/electrocucaracha/openstack-multinode/commit/d1a0d8ef7266087cc68d322dbafce6b426777b4f)

## [23.2.4] - 2024-02-21

### Changed

- Upgraded OpenStack Kolla dependencies to ensure compatibility with latest software releases across various distributions and kolla-ansible and cryptography packages. [2892c866](https://github.com/electrocucaracha/openstack-multinode/commit/2892c8661153f642f20ace4435c4711fd5a06d9d)

## [23.2.3] - 2024-02-02

### Changed

- Upgraded OpenStack Kolla dependencies to ensure compatibility and consistency across various distributions. [bbb732c5](https://github.com/electrocucaracha/openstack-multinode/commit/bbb732c5b84b1b40a5b7c01583ab33bf9257a75f)

## [23.2.2] - 2024-01-17

### Changed

- Optimized caching behavior in GitHub workflows by updating the actions/cache action from version 3.3.3 to 4.0.0, potentially requiring migration steps due to breaking changes affecting compatibility with existing configurations. [26dd4aba](https://github.com/electrocucaracha/openstack-multinode/commit/26dd4abaff07618091a0db8334a473207d2742cd)

## [23.2.1] - 2024-01-12

### Changed

- Upgraded actions/cache to version 3.3.3 for improved performance and security in GitHub Actions workflows. [f877cbf7](https://github.com/electrocucaracha/openstack-multinode/commit/f877cbf78816da7b60e02b59a071b5f62041a6d4)

## [23.2.0] - 2024-01-09

### Added

- Enabled users to access relevant information about cluster setup by introducing a link to Intel's NUC documentation in the aio sample README. [a9154c07](https://github.com/electrocucaracha/openstack-multinode/commit/a9154c0716c8d1499122c0bd9978298f1c743b67)

## [23.1.0] - 2024-01-09

### Added

- Enabled correct locale configuration for users encountering unsupported local settings by introducing a conditional check for dpkg-reconfigure's presence before attempting system configuration. [a0efa15d](https://github.com/electrocucaracha/openstack-multinode/commit/a0efa15dd5462cdc45bfc29db43c578d8ce41af2)

## [23.0.1] - 2024-01-09

### Changed

- Mitogen is no longer installed during the upgrade process due to its limited support in certain Ansible versions. [d9c4159e](https://github.com/electrocucaracha/openstack-multinode/commit/d9c4159e7a021579773f4301e446a6bd039d98ed)

## [23.0.0] - 2024-01-09

### Removed

- Optimized deployment requirements for the 2023.2 release by replacing ansible with ansible-core>=2.14,<2.16. [55c2add0](https://github.com/electrocucaracha/openstack-multinode/commit/55c2add0d7a56be9ca8aea906ca272f8d67d18ca)

## [22.1.34] - 2023-12-20

### Changed

- Updated reviewdog/action-misspell to version 1.15.0, which may introduce breaking behavior if the previous version's configuration has changed due to default setting changes in the updated action. [3c0c0479](https://github.com/electrocucaracha/openstack-multinode/commit/3c0c047968b63117bd181441d1a961713c5a4903)

## [22.1.33] - 2023-12-18

### Changed

- Upgraded OpenStack Kolla dependencies to latest versions including certifi, cryptography, hvac, idna, iso8601, netaddr, oslo-config, oslo-i18n, oslo-utils, packaging, pbr, pytz, requests, urllib3, and wrapt libraries with no breaking behavior or migration requirements. [98dcd340](https://github.com/electrocucaracha/openstack-multinode/commit/98dcd34029c2545dd7acdac42cb9e845260b1f2c)

## [22.1.32] - 2023-12-18

### Changed

- Updated Kolla Ansible to default OpenStack releases to Bobcat (2023.2) for deployment and configuration of OpenStack services. [d5be41bd](https://github.com/electrocucaracha/openstack-multinode/commit/d5be41bde7bf424857bce4d829e1c2e25e9f2e8e)

## [22.1.31] - 2023-12-11

### Changed

- Optimized spell checking functionality by updating reviewdog/action-misspell to version 1.14.1, which does not affect the API or CLI contract and has no security impact. [79e5f130](https://github.com/electrocucaracha/openstack-multinode/commit/79e5f1304faec63a77b5182ba3a99e0c70d21a6a)

## [22.1.30] - 2023-10-25

### Changed

- Updated the GitHub workflow to utilize luizm/action-sh-checker version 0.8.0, which does not introduce any breaking changes but may necessitate verification of compatibility with existing workflows and configurations. [16dfc681](https://github.com/electrocucaracha/openstack-multinode/commit/16dfc681a33024ace76f3435cff079fc10426054)

## [22.1.29] - 2023-10-18

### Changed

- Updated actions/checkout to version 4.1.1, a minor patch update that does not introduce breaking behavior or migration requirements. [d9f2705f](https://github.com/electrocucaracha/openstack-multinode/commit/d9f2705f382830d2e6ab200310ccda9ecc6f1a3a)

## [22.1.28] - 2023-10-12

### Changed

- Optimized image tagging for Rocky OS by switching from codename to version ID in the VERSION_CODENAME variable without introducing any breaking behavior and potentially impacting users who rely on correct image versions requiring them to recheck existing tags. [51459a13](https://github.com/electrocucaracha/openstack-multinode/commit/51459a1399c6f1fe865d27dd7c7369c4749e39e6)

## [22.1.27] - 2023-10-12

### Changed

- Updated the registry CI task to correctly set the base value for each distro, ensuring accurate builds by using the correct base image and requiring users to review their workflows if they were relying on the previous incorrect setting. [d364cb2a](https://github.com/electrocucaracha/openstack-multinode/commit/d364cb2ab683e19db08860ecf8a610dfa4aed011)

## [22.1.26] - 2023-09-25

### Changed

- Updated the dependency on actions/checkout to version 4.1.0, requiring no migration steps for workflows that utilize this action as it does not introduce breaking behavior, API changes, security impact, or config schema modifications. [e23e44c2](https://github.com/electrocucaracha/openstack-multinode/commit/e23e44c29e0ff7995ee33dcfbc487875c720b5e3)

## [22.1.25] - 2023-09-08

### Changed

- Updated the actions/cache dependency to version 3.3.2, which should have no significant impact on users due to its non-intrusive nature and lack of breaking behavior or API changes. [b015d8f3](https://github.com/electrocucaracha/openstack-multinode/commit/b015d8f354ea9a016af312c668e2a157a55630d9)

## [22.1.24] - 2023-09-07

### Changed

- Updated the reviewdog/action-misspell action to version 1.14.0, which may introduce minor changes in spell checking behavior for GitHub workflows that utilize this action. [9499b665](https://github.com/electrocucaracha/openstack-multinode/commit/9499b665c27690db910e118046d3b0a42bf9c01e)

## [22.1.23] - 2023-09-05

### Changed

- Upgraded actions/checkout to version 4.0.0 from 3.5.3, allowing users to leverage new functionality and improvements without introducing breaking changes or requiring migration steps in most cases. [75cbd111](https://github.com/electrocucaracha/openstack-multinode/commit/75cbd111bbf641949478d715eda4b21b679f5d8a)

## [22.1.22] - 2023-07-26

### Changed

- Upgraded OpenStack Kolla dependencies to new versions of certifi, urllib3, and pyyaml, potentially requiring users who rely on these packages to take migration steps. [58ea1f74](https://github.com/electrocucaracha/openstack-multinode/commit/58ea1f746eb96322cfc63d2066b4c0d13cb7c90f)

## [22.1.21] - 2023-07-20

### Changed

- Modernized workflow configuration to use correct operating system images, removing Rocky Linux 9 from the default list and adding Ubuntu 22.04 with zed OS release, requiring users to update their matrix configurations for compatibility. [c26b68b0](https://github.com/electrocucaracha/openstack-multinode/commit/c26b68b0887fa51fd3e843573770e57221f4a525)

## [22.1.20] - 2023-07-20

### Changed

- The Kolla release now includes support for Antelope, enabling users to deploy and manage services like Opensearch and Skyline directly from the release package, while Elasticsearch Curator is no longer included. [94760a74](https://github.com/electrocucaracha/openstack-multinode/commit/94760a74dce3cd834d9513f21d629400475aac9a)

## [22.1.19] - 2023-07-20

### Changed

- Modernized vagrant boxes to official ones affecting CI environment distro versions used for testing. [8524ee0b](https://github.com/electrocucaracha/openstack-multinode/commit/8524ee0bbabad41e8d87c161716eb5f1b49c299a)

## [22.1.18] - 2023-07-20

### Changed

- Updated the default OS_DISTRO variable to ubuntu_22 from its previous default of ubuntu without introducing any breaking behavior. [3f37f844](https://github.com/electrocucaracha/openstack-multinode/commit/3f37f844da974ecdd5fd2a3404e2405c6078db6d)

## [22.1.17] - 2023-07-20

### Changed

- Upgraded OpenStack Kolla dependencies to latest versions, affecting various requirements files across different platforms including CentOS 8, Debian 11, Ubuntu 20 and more. [2fe01075](https://github.com/electrocucaracha/openstack-multinode/commit/2fe01075786d6cba7191f741d2cf654f929c4baa)

## [22.1.16] - 2023-07-20

### Changed

- Modernized operating system version identification to utilize OS VERSION_IDs, improving flexibility and accuracy in handling different Linux distributions across GitHub Actions, Vagrantfiles, and scripts that install dependencies. [1f2c0357](https://github.com/electrocucaracha/openstack-multinode/commit/1f2c035750d4c046f9d451738a34a0d07a067999)

## [22.1.15] - 2023-07-20

### Changed

- Restrictions were enforced on Ansible version usage to ensure compatibility with newer features and bug fixes, requiring at least Ansible 6.0.0 and Ansible Core 2.13.0 while limiting the upper bound of these versions. [19404f2a](https://github.com/electrocucaracha/openstack-multinode/commit/19404f2ab13af05605eb3aeae9844f11d0abd96b)

## [22.1.14] - 2023-07-20

### Changed

- Updated visitor link in README.md to resolve GitHub Super-Linter warnings by replacing the original badge URL with a supported service. [51e20567](https://github.com/electrocucaracha/openstack-multinode/commit/51e20567a1e99fedee3f9e4f8447ccb0fecc215e)

## [22.1.13] - 2023-07-16

### Changed

- Updated the CI environment to utilize the generic/centos8s box instead of centos/stream8, requiring no migration steps for users and leaving the API contract unchanged with no security impact reported. [15237f15](https://github.com/electrocucaracha/openstack-multinode/commit/15237f1580e7fe36b7808a38acc7813765c242e2)

## [22.1.12] - 2023-06-21

### Changed

- Updated reviewdog/action-misspell to version 1.13.1, which introduces minor changes in spell checking behavior without affecting the API or CLI contract and has no security impact. [052e561d](https://github.com/electrocucaracha/openstack-multinode/commit/052e561d09bec2f3fcd81ef32780c48c69cb2e0d)

## [22.1.11] - 2023-06-20

### Changed

- Updated the reviewdog/action-misspell dependency to version 1.13.0, which requires no adjustments to GitHub workflows and maintains the existing API contract. [f71bc48b](https://github.com/electrocucaracha/openstack-multinode/commit/f71bc48be34b74c7ed9a658a026f39fab8ae8219)

## [22.1.10] - 2023-06-12

### Changed

- Updated the actions/checkout dependency to version 3.5.3, which may necessitate adjustments in workflows that previously relied on specific behavior from earlier versions. [5c28329f](https://github.com/electrocucaracha/openstack-multinode/commit/5c28329f561e17c6d21e5922b36734c4bfb12af8)

## [22.1.9] - 2023-05-10

### Changed

- Updated the reviewdog/action-misspell dependency to version 1.12.4, which is likely a maintenance update with no significant user-facing impact. [e7abe8f6](https://github.com/electrocucaracha/openstack-multinode/commit/e7abe8f696573042ecd62db7caab87d3b517a0b0)

## [22.1.8] - 2023-04-20

### Changed

- Upgraded the GitHub repository visualizer dependency to version 0.9.1, introducing new features and bug fixes without altering the API or CLI contract, breaking existing behavior, or affecting config schema integrity. [14c49833](https://github.com/electrocucaracha/openstack-multinode/commit/14c49833e2bbbdc6ab5afffeaabdb5464b7a26a8)

## [22.1.7] - 2023-04-14

### Changed

- Updated the dependency on actions/checkout to version 3.5.2, introducing no breaking behavior and requiring no migration steps. [693d0612](https://github.com/electrocucaracha/openstack-multinode/commit/693d061239b09ce89f7eb4ad232714d5fc21ca89)

## [22.1.6] - 2023-04-13

### Changed

- Updated the actions/checkout dependency to version 3.5.1, ensuring continued support for tasks such as code checkout and dependency installation without introducing any breaking changes. [106a395b](https://github.com/electrocucaracha/openstack-multinode/commit/106a395bea94aedafa8b171a459c8aa2812bf704)

## [22.1.5] - 2023-04-11

### Changed

- Modernized GitHub Super-Linter to version 5.0.0, introducing potential breaking behavior and migration requirements for users with custom linter configurations due to documented API and CLI changes. [e1235276](https://github.com/electrocucaracha/openstack-multinode/commit/e1235276ad94d3a1587893dd698a068a8e55bb61)

## [22.1.4] - 2023-04-04

### Changed

- Upgraded default OpenStack release in kolla to Zed, requiring users to update their configurations accordingly. [f16df6fa](https://github.com/electrocucaracha/openstack-multinode/commit/f16df6fa2bab87cf0315f190955272d96c088f34)

## [22.1.3] - 2023-04-04

### Changed

- Updated the dependency on technote-space/create-pr-action to version 2.1.4, potentially modifying the behavior of existing GitHub Actions workflows. [eea93add](https://github.com/electrocucaracha/openstack-multinode/commit/eea93addf911d2a967bc81776634384ebc0dc6a1)

## [22.1.2] - 2023-04-04

### Changed

- Updated the actions/cache dependency to version 3.2.4, which maintains compatibility with existing workflows and does not introduce any breaking changes or API modifications. [ee74d9d2](https://github.com/electrocucaracha/openstack-multinode/commit/ee74d9d27232a4ffadc9be991e646d623705a037)

## [22.1.1] - 2023-04-04

### Changed

- Updated actions/checkout to version 3.3.0, requiring users of affected workflows to re-run them after the update to utilize the latest version of this action. [e927b3de](https://github.com/electrocucaracha/openstack-multinode/commit/e927b3de019b1499eac9130dc6a5bf993342e8c1)

## [22.1.0] - 2023-04-04

### Added

- Weekly automated verification of OpenStack All-in-One deployments has been enabled for AIO setups via scheduled CI tasks running on Fridays. [e75b5568](https://github.com/electrocucaracha/openstack-multinode/commit/e75b5568679f44bdd6da5f2aaecc19b1c8009973)

## [22.0.3] - 2023-04-04

### Changed

- Upgraded OpenStack Kolla dependencies to ensure continued support for various distributions and their respective package versions. [e4ba88f7](https://github.com/electrocucaracha/openstack-multinode/commit/e4ba88f7d285ca1db2a605caee2df2398f20bf50)

## [22.0.2] - 2023-04-04

### Changed

- Optimized dependencies by updating actions/cache to version 3.3.1, which may require migration steps for workflows using this action and does not introduce any breaking behavior, API changes, or security concerns. [e2466564](https://github.com/electrocucaracha/openstack-multinode/commit/e2466564dc2c58408cfd3254a1a89a1bf7060e01)

## [22.0.1] - 2023-04-04

### Changed

- Simplified the undercloud provisioning scripts to improve maintainability and user experience by replacing complex logic with streamlined functions for dependency installation, Ansible setup, proxy configuration, Python package conflict resolution on Ubuntu-based systems, and removal of redundant docker source lists. [db4d7f62](https://github.com/electrocucaracha/openstack-multinode/commit/db4d7f6271a828f17f6c6ad9ed49efa860bc0824)

## [22.0.0] - 2023-04-04

### Removed

- Eliminated support for CentOS, requiring users to adjust their environment settings to accommodate the new default distributions. [db428a59](https://github.com/electrocucaracha/openstack-multinode/commit/db428a59caa03ade9869881eee011c8676eaadad)

## [21.2.8] - 2023-04-04

### Changed

- Updated system requirements files across various operating systems to reflect upgraded OpenStack Kolla dependencies, including oslo-config, packaging, cryptography, certifi, and pytz version updates. [ce463434](https://github.com/electrocucaracha/openstack-multinode/commit/ce463434cf5fe95f3a1f395fb610375e296bfd1a)

## [21.2.7] - 2023-04-04

### Changed

- Updated the cache action in GitHub workflows to version 3.2.2, which may require migration steps for users who have customized their workflow configurations for caching actions. [ce053d62](https://github.com/electrocucaracha/openstack-multinode/commit/ce053d6223040c9e4c48583d824f7d94514ca70b)

## [21.2.6] - 2023-04-04

### Changed

- Modernized the GitHub Super Linter dependency to version 4.10.0, introducing minor improvements and possible changes in linter rules and configurations that users should review in the release notes for their workflows. [c99213db](https://github.com/electrocucaracha/openstack-multinode/commit/c99213dbb02adf38a485a638756e89b4dc48c187)

## [21.2.5] - 2023-04-04

### Changed

- Modernized the Automatic Rebase job in the .github/workflows/rebase.yml workflow to utilize version 1.8 of the cirrus-actions/rebase dependency, which may necessitate manual review for migration requirements and API contract changes. [c27aef92](https://github.com/electrocucaracha/openstack-multinode/commit/c27aef92e52265d0ec610aa632af5f596e1b75b1)

## [21.2.4] - 2023-04-04

### Changed

- Simplified installation of binary dependencies by introducing a unified command that eliminates redundant steps and uses the `PKG_BINDEP_PROFILE=compute` environment variable to determine required packages with no migration requirements for users installing the compute script. [c191d946](https://github.com/electrocucaracha/openstack-multinode/commit/c191d946edeabdc82d2c202d00d875f5c6c03a4a)

## [21.2.3] - 2023-04-04

### Changed

- Enabled create-pr-action workflows to push code and create pull requests without requiring any migration steps. [c15294c7](https://github.com/electrocucaracha/openstack-multinode/commit/c15294c7a95feb1b20aa93f7bb4d7ce24c0fdc6e)

## [21.2.2] - 2023-04-04

### Changed

- Stabilized GitHub workflows for on-demand and scheduled AIO jobs by updating the configuration to directly assign output results instead of using `::set-output` syntax. [c0a33493](https://github.com/electrocucaracha/openstack-multinode/commit/c0a3349316adbdf75fd6da08c91c689a8c2ca268)

## [21.2.1] - 2023-04-04

### Changed

- Optimized undercloud setup on Ubuntu systems by excluding python3-openssl package from installation by default to prevent potential conflicts with other packages that depend on its absence and to ensure a stable configuration. [bb5f4895](https://github.com/electrocucaracha/openstack-multinode/commit/bb5f4895a81fd7cd3e4499a4109da45bf0abc713)

## [21.2.0] - 2023-04-04

### Added

- Enabled behavior-driven development for Bash shell scripts through the introduction of ShellSpec BDD support, including new workflows and configuration files to run Shellspec tests. [bb5a907a](https://github.com/electrocucaracha/openstack-multinode/commit/bb5a907a70abcdece8e78c15cdc693e588e979fb)

## [21.1.2] - 2023-04-04

### Changed

- Updated to the latest version of GitHub Super Linter (4.10.1), which may introduce minor changes in linter rules and behavior but does not affect API or CLI contract, security, or config schema. [ba74b2f4](https://github.com/electrocucaracha/openstack-multinode/commit/ba74b2f4a0e53b37b45c877c3eb033c7a4b56fe8)

## [21.1.1] - 2023-04-04

### Changed

- Updated the reviewdog/action-misspell dependency to version 1.12.3, which may introduce minor changes in spell checking behavior due to the patch release nature of this update. [b7a12ec3](https://github.com/electrocucaracha/openstack-multinode/commit/b7a12ec30e27ce00534c955bbbcb13da8a627bd2)

## [21.1.0] - 2023-04-04

### Added

- Enabled repository access to comprehensive GitHub workflow documentation, providing developers with an overview of available workflows and their run events and triggers. [b64f0ebf](https://github.com/electrocucaracha/openstack-multinode/commit/b64f0ebf7783d5243a16a721f514e37f0fa7ff38)

## [21.0.0] - 2023-04-04

### Removed

- Simplified the deployment process by removing smoke tests for kolla actions and instead requiring users to utilize the `get_kolla_actions` function to dynamically determine the correct action sequence based on Ansible version and deploy profile. [b579e7ee](https://github.com/electrocucaracha/openstack-multinode/commit/b579e7ee4bcf31a89185eca25c975913c1fcd77f)

## [20.1.8] - 2023-04-04

### Changed

- Upgraded dependencies for OpenStack Kolla to ensure compatibility and maintain package integrity across multiple distros and versions of various packages. [b478a4c0](https://github.com/electrocucaracha/openstack-multinode/commit/b478a4c0a034d6043cffa69ddfd7e4fdd371c124)

## [20.1.7] - 2023-04-04

### Changed

- Upgraded OpenStack Kolla dependencies across multiple distros including Ubuntu Debian and CentOS to newer package versions without introducing any breaking changes or requiring migration steps. [b42c7ef7](https://github.com/electrocucaracha/openstack-multinode/commit/b42c7ef77154aeb29616bd1be76be44eb146788f)

## [20.1.6] - 2023-04-04

### Changed

- Kolla's default installation type has been switched to binary, requiring users to update their configurations in files like `etc/kolla/globals.yml` and `defaults.env`. [9b61a136](https://github.com/electrocucaracha/openstack-multinode/commit/9b61a1368e22df1d0fdb27af8b5f9e501977fda8)

## [20.1.5] - 2023-04-04

### Changed

- Upgraded OpenStack Kolla dependencies to newer versions affecting various distros including Ubuntu, Debian, and CentOS without introducing breaking behavior or requiring migration. [9980b53e](https://github.com/electrocucaracha/openstack-multinode/commit/9980b53e509ca2aff2da110536808ef43a6146ec)

## [20.1.4] - 2023-04-04

### Changed

- Mitogen is now optional and can be disabled by manually removing its configuration from /etc/ansible/ansible.cfg. [97d4ee17](https://github.com/electrocucaracha/openstack-multinode/commit/97d4ee17a77b62025d7b47a82c6ea4c604b84422)

## [20.1.3] - 2023-04-04

### Changed

- Updated the GitHub Super Linter dependency to version 4.9.7, introducing potential updates to linter rules that may require migration steps for existing workflows using this dependency. [93ba1a86](https://github.com/electrocucaracha/openstack-multinode/commit/93ba1a869f31d0c631bdaa47e8122cefb0c56d09)

## [20.1.2] - 2023-04-04

### Changed

- Updated the actions/cache dependency to version 3.0.11, ensuring that workflows continue to function as expected without breaking behavior and maintaining the existing API contract. [91e54743](https://github.com/electrocucaracha/openstack-multinode/commit/91e54743c7f19cdef1f1f91f42074433812924f7)

## [20.1.1] - 2023-04-04

### Changed

- Updated binary dependencies for Debian nodes to include essential packages, ensuring undercloud environments on these platforms can be properly installed and configured without additional manual intervention. [8f68571a](https://github.com/electrocucaracha/openstack-multinode/commit/8f68571ae248fc54a6f9198e80c8aeb6b547aecf)

## [20.1.0] - 2023-04-04

### Added

- Introduced base requirements for zed that include specific versions of dependencies to ensure consistency across various platforms, which may require migration steps when updating from previous versions. [8eac9fe1](https://github.com/electrocucaracha/openstack-multinode/commit/8eac9fe10c75e9cbbb501b58d6fc25e1964bab39)

## [20.0.12] - 2023-04-04

### Changed

- Optimized AIO CI matrix generation to append the generated matrix to the GitHub output instead of overwriting it ensuring subsequent steps can access and use the matrix as intended without requiring manual updates. [8855ee15](https://github.com/electrocucaracha/openstack-multinode/commit/8855ee15f598dc0ade222115308dfda3c99da616)

## [20.0.11] - 2023-04-04

### Changed

- Streamlined All-in-One deployment and upgrade processes are now enabled for users through simplified automation of previously manual steps. [87f6f296](https://github.com/electrocucaracha/openstack-multinode/commit/87f6f296ac5a643486a77a09324f8cffa5e53960)

## [20.0.10] - 2023-04-04

### Changed

- Updated the GitHub Action for markdown link checking to version 1.0.14, which may introduce breaking behavior if the previous configuration relied on specific features of 1.0.13. [83724d5e](https://github.com/electrocucaracha/openstack-multinode/commit/83724d5e4253dfeb8002ea19b16c3ceaccc9783e)

## [20.0.9] - 2023-04-04

### Changed

- Updated the actions/cache dependency to version 3.2.3, which may require manual cache invalidation due to breaking changes in the new version. [8341ab5a](https://github.com/electrocucaracha/openstack-multinode/commit/8341ab5aa558f20afb60479e8e049dac9cfd46e9)

## [20.0.8] - 2023-04-04

### Changed

- Upgraded OpenStack Kolla dependencies and distro list versions to the latest available releases. [8232531a](https://github.com/electrocucaracha/openstack-multinode/commit/8232531aa2b71a9524d205448cdf14ceddc36fd9)

## [20.0.7] - 2023-04-04

### Changed

- Updated actions/cache dependency to version 3.2.6, preserving the existing API contract and introducing no breaking behavior. [7c7b9fbb](https://github.com/electrocucaracha/openstack-multinode/commit/7c7b9fbb5433e4141db9226e105f11e09bdd4b17)

## [20.0.6] - 2023-04-04

### Changed

- Enabled verbose output in debug mode for the run kolla action script to provide detailed information to users when running the script with OS_DEBUG set to true. [78e5bcce](https://github.com/electrocucaracha/openstack-multinode/commit/78e5bccec0226743c588dc8a2de00adc9fe0b9ea)

## [20.0.5] - 2023-04-04

### Changed

- Updated to version 0.7.0 of luizm/action-sh-checker, introducing new features and potential migration requirements due to the semver-minor update type. [7683f611](https://github.com/electrocucaracha/openstack-multinode/commit/7683f611cce05c3bc3239a5a424ef10b0d428c94)

## [20.0.4] - 2023-04-04

### Changed

- Updated actions/cache to version 3.2.5, which includes bug fixes and performance improvements likely resulting from minor patch release changes. [704ade46](https://github.com/electrocucaracha/openstack-multinode/commit/704ade46526bbc447877a1e521503d52b4c79f8f)

## [20.0.3] - 2023-04-04

### Changed

- Simplified GitHub Actions workflows for building and testing OpenStack samples now change into the relevant sample directories before running Vagrant commands using a working directory instruction, making workflow configurations more consistent and eliminating the need for explicit cd commands in existing workflows. [66bef58d](https://github.com/electrocucaracha/openstack-multinode/commit/66bef58d105648d200f44d4cce75830bfc20b20c)

## [20.0.2] - 2023-04-04

### Changed

- Upgraded to version 3.3.0 of the actions/cache dependency, enabling users to take advantage of new features and bug fixes without requiring any breaking changes or alterations to existing workflows. [5f87f3f4](https://github.com/electrocucaracha/openstack-multinode/commit/5f87f3f45d3178da802e5f1cab9f910175b74f05)

## [20.0.1] - 2023-04-04

### Changed

- Optimized parallelism during updates by setting max-parallel strategy to 1 and simplifying the EXECUTE_COMMANDS script, requiring users who rely on concurrent updates to adjust their workflows accordingly. [5e93f14c](https://github.com/electrocucaracha/openstack-multinode/commit/5e93f14cf9e4e8c1468256d21d592ddc786d9863)

## [20.0.0] - 2023-04-04

### Removed

- Simplified unnecessary UART configuration instructions in aio, distributed, and noha sample Vagrantfiles by removing VirtualBox-specific code due to an upstream bug that made these configurations redundant thereby reducing unnecessary code and potentially simplifying maintenance and development workflows. [58e1a318](https://github.com/electrocucaracha/openstack-multinode/commit/58e1a3181f384658c6d966fb825f222598fbb559)

## [19.3.8] - 2023-04-04

### Changed

- Upgraded OpenStack Kolla dependencies to 13.5.0 and pytz to 2022.4 in various requirements files. [559f680f](https://github.com/electrocucaracha/openstack-multinode/commit/559f680fadaf7be72b3775f9cb1cb0c7fab5585a)

## [19.3.7] - 2023-04-04

### Changed

- The run_kaction script's behavior has been optimized to improve usability by modifying how certain Ansible command-line options are handled without introducing any breaking changes. [53a9ce8b](https://github.com/electrocucaracha/openstack-multinode/commit/53a9ce8bd6c960dc9b69bde33ae311a395776ee9)

## [19.3.6] - 2023-04-04

### Changed

- Updated luizm/action-sh-checker to version 0.6.0, introducing potential changes in the sh-checker's behavior that users should review through the release notes and commit history for necessary adjustments. [47b20c13](https://github.com/electrocucaracha/openstack-multinode/commit/47b20c13deaf58a80dbe1072fcf095f08604c6c1)

## [19.3.5] - 2023-04-04

### Changed

- Updated specific versions for GitHub Actions in various workflows to ensure compatibility and consistency across different environments by upgrading the `actions/checkout` action version from 3 to 3.1.0 and other actions like `githubocto/repo-visualizer`, `technote-space/create-pr-action`, and `luizm/action-sh-checker`. [46e6239e](https://github.com/electrocucaracha/openstack-multinode/commit/46e6239e429f986b6ec253de732603f6f24a69be)

## [19.3.4] - 2023-04-04

### Changed

- Upgraded actions/checkout dependency to version 3.4.0, introducing no breaking behavior and requiring potential migration steps in workflows utilizing this dependency. [3eb18d88](https://github.com/electrocucaracha/openstack-multinode/commit/3eb18d88228faedb928d43674fc238508e8b88ef)

## [19.3.3] - 2023-04-04

### Changed

- Simplified setup for users by automating base requirements installation on NOHA nodes without introducing breaking behavior and requiring no migration steps from previous versions. [3c0e7ba6](https://github.com/electrocucaracha/openstack-multinode/commit/3c0e7ba69570fbbf238eef0e8c5f334794256fe2)

## [19.3.2] - 2023-04-04

### Changed

- Updated the actions/checkout dependency to version 3.2.0, which may require migration steps in workflows that utilize this action due to potential minor breaking changes. [38fd1e69](https://github.com/electrocucaracha/openstack-multinode/commit/38fd1e69e5cfd3b56d637b4044fa33a11afa555c)

## [19.3.1] - 2023-04-04

### Changed

- Optimized GitHub cache management to support Linux distributions other than Ubuntu and updated dependencies for backward compatibility without requiring migration steps. [33e765f7](https://github.com/electrocucaracha/openstack-multinode/commit/33e765f77c26fb00c6cd05cc725284641e7c3ad1)

## [19.3.0] - 2023-04-04

### Added

- Enabled systems to automatically configure system DNS settings using Google's public DNS servers when a specific netplan configuration file is present, potentially requiring manual intervention if custom DNS settings are in place. [331e8755](https://github.com/electrocucaracha/openstack-multinode/commit/331e8755be93bcabbbea80f6a2d77fe7a46b4025)

## [19.2.24] - 2023-04-04

### Changed

- Updated the actions/checkout action to version 3.5.0, introducing new features and improvements without altering its API or CLI contract, and thus requiring no migration steps for affected workflows. [32d9d792](https://github.com/electrocucaracha/openstack-multinode/commit/32d9d7926ee613e3b5f6c6a4734f5721e1d5295f)

## [19.2.23] - 2023-04-04

### Changed

- Upgraded the GitHub Action for markdown link checking to version 1.0.15, introducing no breaking changes and maintaining compatibility with existing API and CLI contracts. [23a9b653](https://github.com/electrocucaracha/openstack-multinode/commit/23a9b653c7a4dd10dbb4bcc736724b54e37f0951)

## [19.2.22] - 2023-04-04

### Changed

- Clarified Kolla's role in container-based architecture by providing its purpose and relation to OpenStack services deployment tools in the README.md file. [21affb5f](https://github.com/electrocucaracha/openstack-multinode/commit/21affb5f3c278ebc2b35d10a1363bc2086706509)

## [19.2.21] - 2023-04-04

### Changed

- Enabled users to deploy on Rocky Linux alongside existing CentOS, Debian, and Ubuntu options by updating CI workflows, Vagrantfile configurations, and dependencies in requirements files. [1f2bc803](https://github.com/electrocucaracha/openstack-multinode/commit/1f2bc8031f57c10f3a52852476a9e405b4b19456)

## [19.2.20] - 2023-04-04

### Changed

- Tox configuration updated to resolve compatibility issues with version 4, specifically addressing environment variable handling and command execution in the linter test environment. [18d857cc](https://github.com/electrocucaracha/openstack-multinode/commit/18d857cc5b1e004a0a3b0970c551175fa7f8d84b)

## [19.2.19] - 2023-04-04

### Changed

- Corrected the benefits section in the README document to accurately reflect containerized deployment characteristics. [ef903ce4](https://github.com/electrocucaracha/openstack-multinode/commit/ef903ce41dbe8ecdf07c27c6b4b78d6818fcb5b8)

## [19.2.18] - 2022-08-29

### Changed

- Enabled users to directly access the latest version of the init-runonce script from the Kolla-Ansible repository without manual updates, eliminating potential security risks associated with external downloads and requiring no additional configuration changes. [e4ae329f](https://github.com/electrocucaracha/openstack-multinode/commit/e4ae329fc3dee00af15b6a022b5a3d6a18b53b78)

## [19.2.17] - 2022-08-29

### Changed

- Optimized Bash script formatting is now achieved through the automatic application of shfmt rules across undercloud and node setup scripts resulting in improved code consistency and readability. [4b8a82fe](https://github.com/electrocucaracha/openstack-multinode/commit/4b8a82fec3eb086bae7b0898d0492ce007e8b2a7)

## [19.2.16] - 2022-08-29

### Changed

- Vagrantfiles were updated to address Rubocop issues, making them compliant with the tool's guidelines. [0669671c](https://github.com/electrocucaracha/openstack-multinode/commit/0669671c8cd43bbf5dfe161e015bec75d7932a18)

## [19.2.15] - 2022-08-29

### Changed

- Enabled virtiofs mount type in libvirt provider for Vagrantfiles, replacing nfs synced folder type and improving performance without introducing breaking behavior or API changes that require configuration updates from users of distributed and noha samples. [e87b0c45](https://github.com/electrocucaracha/openstack-multinode/commit/e87b0c45b99f15c688cef18114e457a558bf59a7)

## [19.2.14] - 2022-08-11

### Changed

- Diagram generation has been enabled for users to visualize their project's structure through the creation of a new SVG file named codebase-structure.svg. [29425177](https://github.com/electrocucaracha/openstack-multinode/commit/2942517799e240e1fe2a2938b7bc2238112d1398)

## [19.2.13] - 2022-08-11

### Changed

- Workflows now allow unrestricted updates of python requirements files in jobs due to the modification of update permissions to grant write access. [b52c5e08](https://github.com/electrocucaracha/openstack-multinode/commit/b52c5e0817e7cd51d14ac8ac2890304d2832b735)

## [19.2.12] - 2022-08-11

### Changed

- Updated the GitHub Super-Linter dependency to version 4.9.6, which may introduce breaking changes in linter rules or configurations that maintainers must review and update accordingly. [a657df96](https://github.com/electrocucaracha/openstack-multinode/commit/a657df963681ff55a9b031602602ecd8a4a8d549)

## [19.2.11] - 2022-08-05

### Changed

- Upgrades are now validated by deploying the previous release and verifying OpenStack services, requiring no migration steps but introducing a new `OPENSTACK_RELEASE` environment variable. [2042418d](https://github.com/electrocucaracha/openstack-multinode/commit/2042418df13ae0daf3bf0b80b16caec90d4162c1)

## [19.2.10] - 2022-08-05

### Changed

- The CI matrix for All-in-One deployment on Virtual Machines now dynamically generates the list of supported distributions, replacing the hardcoded list. [5d02aefb](https://github.com/electrocucaracha/openstack-multinode/commit/5d02aefbd837d04414e7501ac4d651264cfa10c3)

## [19.2.9] - 2022-08-05

### Changed

- Enabled flexible dependency management across different OpenStack releases by allowing multiple Python requirements files to be used for resolving and installing dependencies in various environments. [338e1ba1](https://github.com/electrocucaracha/openstack-multinode/commit/338e1ba119696f1334a93b06da1391643f5cade3)

## [19.2.8] - 2022-07-26

### Changed

- Updated github/super-linter to version 4.9.5, which may break behavior in workflows that rely on the previous version's configuration due to changes in pull_request_review path handling. [7c6e8740](https://github.com/electrocucaracha/openstack-multinode/commit/7c6e8740ae896aa79cddf987a0d8972342d4bf48)

## [19.2.7] - 2022-07-18

### Changed

- Upgraded OpenStack Kolla dependencies to newer versions across various distros including Ubuntu Debian and CentOS potentially requiring migration steps for compatibility. [2bfdfb88](https://github.com/electrocucaracha/openstack-multinode/commit/2bfdfb886fc238ee9a0ff651ade95aeb1e3dcd16)

## [19.2.6] - 2022-07-11

### Changed

- The Vagrant trigger instruction now correctly prints OpenStack environment variables by adding an OR operator to the printenv command, preventing errors when no matching variables are found. [689f36f6](https://github.com/electrocucaracha/openstack-multinode/commit/689f36f6136d011603d4352b084afac85fc09bb2)

## [19.2.5] - 2022-07-01

### Changed

- Upgraded OpenStack Kolla dependencies to latest versions, impacting multiple distros and packages including Ansible, certifi, cffi, requests, kolla-ansible, and oslo-utils without introducing breaking behavior or requiring migrations. [da7a2f29](https://github.com/electrocucaracha/openstack-multinode/commit/da7a2f29bcfe7edd290d263c1a23f166049f1e40)

## [19.2.4] - 2022-07-01

### Changed

- Upgraded macOS CI environment to version 12, resulting in potentially improved performance and compatibility for builds executed on macOS-based systems. [4da18a52](https://github.com/electrocucaracha/openstack-multinode/commit/4da18a52431f974922abb35369e9d38feb7fc4b3)

## [19.2.3] - 2022-07-01

### Changed

- Enforced Cloudflare DNS usage for all setups which may require users to migrate their customized DNS settings away from other services. [d072e3a5](https://github.com/electrocucaracha/openstack-multinode/commit/d072e3a53c98a4c1bbe39ab280aa502b526cb548)

## [19.2.2] - 2022-06-08

### Changed

- Users are now correctly added to the docker group only if they do not already have it preventing unnecessary modifications. [50d7bf11](https://github.com/electrocucaracha/openstack-multinode/commit/50d7bf1114a3e9d369787a2dd8de328368ac9284)

## [19.2.1] - 2022-06-08

### Changed

- Simplified package builds for Debian and Ubuntu by eliminating unnecessary python-openstackclient installations via pip-compile. [c672616b](https://github.com/electrocucaracha/openstack-multinode/commit/c672616b06581f7e9df7d277d85a5bc070b967ab)

## [19.2.0] - 2022-06-08

### Added

- Enabled HA setups for rabbit hostname resolution by allowing unique IP address assignment without requiring user intervention beyond a one-time manual hosts file update. [3b9f90c2](https://github.com/electrocucaracha/openstack-multinode/commit/3b9f90c2f22655cf41a25bcf4611aac49b503e8c)

## [19.1.3] - 2022-06-08

### Changed

- Optimized Distributed setup to reduce memory and vCPUs for most nodes while increasing disk space for the Storage Node without breaking existing behavior or changing API contracts, requiring migration steps to update node configurations in smaller environments. [e39817d9](https://github.com/electrocucaracha/openstack-multinode/commit/e39817d9eb8931111d5d0510d2ada109d0eb90bb)

## [19.1.2] - 2022-06-08

### Changed

- Enabled insecure local registry usage by default to simplify configuration for users who want to utilize their own Docker registries without additional setup requirements. [e9645172](https://github.com/electrocucaracha/openstack-multinode/commit/e9645172e3fd6fa1478d4d4f74c99daacac1265c)

## [19.1.1] - 2022-06-08

### Changed

- Simplified No HA ssh configuration by removing insecure key handling and using nodeconfig triggers to configure authorized keys after provisioning. [41ba2783](https://github.com/electrocucaracha/openstack-multinode/commit/41ba2783d4fe4f546e25013f4f980b10fdd3c1df)

## [19.1.0] - 2022-06-08

### Added

- Enabled users to view OpenStack environment variables directly from the Vagrant console upon VM startup without requiring additional setup or configuration changes. [155e34ac](https://github.com/electrocucaracha/openstack-multinode/commit/155e34ac8f23ebce467d83017ac2ef324128b310)

## [19.0.0] - 2022-06-08

### Removed

- Eliminated Docker from compute dependencies, requiring users to update their compute.sh script and potentially reinstall it if necessary for their workflow. [047b4ae4](https://github.com/electrocucaracha/openstack-multinode/commit/047b4ae470dce69fb170355f477910a6dab7adb3)

## [18.0.0] - 2022-06-06

### Removed

- Eliminated support for specific versions of Venus by removing its registry configuration from the kolla-build.ini file, which may necessitate migration to utilize the latest version. [52b514c1](https://github.com/electrocucaracha/openstack-multinode/commit/52b514c1213d99184b80ae0ba6b0c3c741797eff)

## [17.1.1] - 2022-06-06

### Changed

- Upgraded OpenStack Kolla dependencies to affect supported distros and requirements files for Ubuntu 20.04 and Debian Bullseye users who may need migration steps. [5323984a](https://github.com/electrocucaracha/openstack-multinode/commit/5323984ad74b13d13f1e290b26522467ef4f14f7)

## [17.1.0] - 2022-06-06

### Added

- Enabled suppression of Apache website link checking during deployment to prevent validation interruptions for users relying on this feature. [eea0e4fc](https://github.com/electrocucaracha/openstack-multinode/commit/eea0e4fc3c561f1771f6181747277ea5f3a3b10c)

## [17.0.15] - 2022-06-06

### Changed

- Updated the GitHub Super Linter dependency to version 4.9.3, which may introduce changes in linter rules and configurations that users should review for any API or CLI contract impacts on their workflows. [b69d1b6d](https://github.com/electrocucaracha/openstack-multinode/commit/b69d1b6dcfda8a6ec54faadc32721aaf13cf62d1)

## [17.0.14] - 2022-06-06

### Changed

- Optimized Ansible execution performance by enabling multi-threading on systems with multiple cores through the adoption of the mitogen plugin. [94f27c1f](https://github.com/electrocucaracha/openstack-multinode/commit/94f27c1fa55e690bed31a548c1fa13e693626445)

## [17.0.13] - 2022-06-06

### Changed

- Refactored configuration management to utilize base.in requirements instead of maintaining a separate list in centos.in. [93afab16](https://github.com/electrocucaracha/openstack-multinode/commit/93afab16cf33c6e3bda206e0286a8245931c8ad5)

## [17.0.12] - 2022-06-06

### Changed

- Upgraded OpenStack Kolla dependencies to updated versions of Ansible, OpenStack SDK, and other related tools, potentially requiring migration steps for users relying on these packages for infrastructure management. [edecc86c](https://github.com/electrocucaracha/openstack-multinode/commit/edecc86cfd73fb7acf072e449a1855327ef17779)

## [17.0.11] - 2022-06-06

### Changed

- Upgraded to OpenStack Yoga release, which requires users to review their configuration files for changes related to the new Ansible version and potentially migrate services. [6615ecb3](https://github.com/electrocucaracha/openstack-multinode/commit/6615ecb32169ad3f931a60a5697c6b782f538e83)

## [17.0.10] - 2022-05-24

### Changed

- Optimized Ansible configuration settings to enable pipeline execution and modify SSH connection parameters, affecting deployment operations for developers and potentially impacting migration from existing configurations. [c8e25e94](https://github.com/electrocucaracha/openstack-multinode/commit/c8e25e9487c366fa69e48bd5e82ba56a64623605)

## [17.0.9] - 2022-05-24

### Changed

- Simplified the installation process by displaying CPU usage and memory free space statistics directly during setup via the install.sh script. [6de28870](https://github.com/electrocucaracha/openstack-multinode/commit/6de28870c47be6be204ea0f0b20cf0bb76b8548d)

## [17.0.8] - 2022-05-24

### Changed

- Updated the CI workflow to disable heat and horizon services by default, affecting users who rely on these services for testing and validation and requiring them to update their workflows accordingly. [299f956f](https://github.com/electrocucaracha/openstack-multinode/commit/299f956f467420264f2b0d3fd90554972d0cc78d)

## [17.0.7] - 2022-05-24

### Changed

- Enabled time statistics to be printed out after various installation processes, including compute, install, node setup, registry creation, and undercloud provisioning, providing users with additional information on process completion times. [ea832315](https://github.com/electrocucaracha/openstack-multinode/commit/ea83231574a4d645f4ae18fe00089842c569af12)

## [17.0.6] - 2022-05-11

### Changed

- Upgraded dependencies for OpenStack Kolla to latest versions including ansible-core 2.11.11, cmd2 2.4.1, cryptography 37.0.2, jsonpointer 2.3, oslo-utils 4.13.0, pbr 5.9.0, and prettytable 3.3.0 without introducing any breaking behavior or migration requirements. [e8a50c27](https://github.com/electrocucaracha/openstack-multinode/commit/e8a50c27c2ae8c1d155dbd790e99dc309e09bf67)

## [17.0.5] - 2022-05-11

### Changed

- Modernized cirrus-actions/rebase to version 1.7, preserving the existing API contract and requiring no manual intervention in workflows that utilize this action. [bbfb3f3e](https://github.com/electrocucaracha/openstack-multinode/commit/bbfb3f3e892c8f60b59cd2eedfb187c6edc1480c)

## [17.0.4] - 2022-05-03

### Changed

- Enabled automation of tool installation and configuration for CI tasks through the creation of a custom Vagrant setup GitHub action, eliminating manual caching of Vagrant boxes and resolving VBoxHeadless issues on macOS by applying workarounds. [68355213](https://github.com/electrocucaracha/openstack-multinode/commit/68355213b55ba1ec169b0ad3df81932bbabb6f55)

## [17.0.3] - 2022-05-03

### Changed

- Updated Debian support to align with the latest Bullseye release, impacting users on Debian-based systems who must update their CI workflows and adjust requirements accordingly. [84721652](https://github.com/electrocucaracha/openstack-multinode/commit/847216524c17ca3d17935425803b859241653b3e)

## [17.0.2] - 2022-05-03

### Changed

- Optimized the Automatic Rebase step of the .github/workflows/rebase.yml workflow by updating cirrus-actions/rebase to version 1.6, which may introduce breaking changes for users relying on this workflow for automatic rebasing. [630fb12c](https://github.com/electrocucaracha/openstack-multinode/commit/630fb12c30fb58e701ea4be29e88a01ec6eaa67f)

## [17.0.1] - 2022-05-03

### Changed

- Upgraded configuration files to align with yoga release requirements enabling default services for ironic, designate, and prometheus while updating config schema in kolla-build.ini, passwords.yml, and registry.sh without introducing breaking behavior or API changes. [ee08483e](https://github.com/electrocucaracha/openstack-multinode/commit/ee08483e09cb925d50f98dd97b5a5ef8eb4dedf3)

## [17.0.0] - 2022-05-03

### Removed

- Upgraded dependencies to eliminate CentOS-specific Python version constraints, requiring manual migration steps for users running older versions of affected packages. [dd7b7bfa](https://github.com/electrocucaracha/openstack-multinode/commit/dd7b7bfa007d8c489d4def6ed79dcaa1932d4069)

## [16.4.18] - 2022-05-03

### Changed

- Simplified the base OS requirements installation process by centralizing it into a single script that is now used for provisioning in various samples. [cad2acec](https://github.com/electrocucaracha/openstack-multinode/commit/cad2acec6bbdad9dbd06471dd25ed93c61a425a8)

## [16.4.17] - 2022-04-07

### Changed

- The removal process for unnecessary packages in undercloud.sh is now hardened against potential errors on different Linux distributions by checking package installation status before attempting to remove it. [088d1764](https://github.com/electrocucaracha/openstack-multinode/commit/088d17645d1887bf414bedee2d5377fb0e8fb9fb)

## [16.4.16] - 2022-04-04

### Changed

- Increased the memory allocated to OpenStack Compute nodes in the NoHA CI job from 10240 MB to 8192 MB and from 2048 MB to 4096 MB for compute01 vagrant up step. [fbcac986](https://github.com/electrocucaracha/openstack-multinode/commit/fbcac98665d59acefd25f5da85a6119c4ff7b008)

## [16.4.15] - 2022-04-04

### Changed

- Updated the main README.md file to reflect changes in underlying operating systems used for certain configurations without introducing any breaking behavior or API/CLI contract changes. [dde7dce0](https://github.com/electrocucaracha/openstack-multinode/commit/dde7dce01ee3b76fef84a2cdb9a73556549397b4)

## [16.4.14] - 2022-04-04

### Changed

- Upgraded GitHub Super Linter to version 4.9.2, introducing no breaking changes and requiring no migration steps for existing users. [460125db](https://github.com/electrocucaracha/openstack-multinode/commit/460125db37e2d3265b139d3d90237ed78d04367b)

## [16.4.13] - 2022-04-04

### Changed

- Improved the update distro CI job to install vagrant using a new script that achieves the same result as before but may require manual intervention for users with non-standard local environments. [c9be572c](https://github.com/electrocucaracha/openstack-multinode/commit/c9be572c986405e7a4b6f3c99a491ddd6427b078)

## [16.4.12] - 2022-03-30

### Changed

- Enabled the heat service in NOHA by default, impacting users who rely on this feature for orchestration tasks and requiring them to update configurations that previously enabled it to reflect its new default state. [2a649b0f](https://github.com/electrocucaracha/openstack-multinode/commit/2a649b0f080e0981f6b05315d802bc77dc9c430d)

## [16.4.11] - 2022-03-30

### Changed

- Updated OS_KOLLA_NEUTRON_PLUGIN_AGENT in aio and noha configs to use the linuxbridge plugin agent, requiring users to adjust their existing configurations as a result. [d71418cd](https://github.com/electrocucaracha/openstack-multinode/commit/d71418cd14fc4a0c98f63cf0e7e85ea01c07f989)

## [16.4.10] - 2022-03-29

### Changed

- pip installation is now isolated to specific users' Python environments instead of relying on system-wide installations. [e4b80e6b](https://github.com/electrocucaracha/openstack-multinode/commit/e4b80e6b30ddaa237d6d89cd3dbaab25759745ec)

## [16.4.9] - 2022-03-29

### Changed

- Updated Jinja2 version to 3.0.3 in requirements files, requiring re-running pip-compile and updating dependencies for deploy actions in OpenStack environments with Kolla-Ansible. [b1747ed6](https://github.com/electrocucaracha/openstack-multinode/commit/b1747ed6b4b1d36d917c3d6e2e344746df4162b8)

## [16.4.8] - 2022-03-29

### Changed

- Enabled Prometheus Libvirt Exporter by default in globals.yml and updated config files for the Xena release, affecting users who manage Prometheus configurations. [41f02b10](https://github.com/electrocucaracha/openstack-multinode/commit/41f02b10d82c73280d9e534a76cab169a0b361fd)

## [16.4.7] - 2022-03-28

### Changed

- Updated the GitHub Super Linter dependency to version 4.9.1, introducing no breaking changes but requiring a manual update of the linter configuration in `.github/workflows/linter.yml` to 4.9.1. [9fed99f5](https://github.com/electrocucaracha/openstack-multinode/commit/9fed99f5de32074e6813b5e8bef559e36333b060)

## [16.4.6] - 2022-03-25

### Changed

- Updated OpenStack Kolla dependencies to ensure compatibility across multiple operating systems and libraries including cryptography, debtcollector, keystoneauth1, and others. [67896529](https://github.com/electrocucaracha/openstack-multinode/commit/67896529f0e4bf488e186a985766497ef71cdf38)

## [16.4.5] - 2022-03-25

### Changed

- The CI job for updating Python requirements now supports different Linux distributions by using specific package managers for each OS. [f5fff6bf](https://github.com/electrocucaracha/openstack-multinode/commit/f5fff6bf903f34dc97180147ee38fdc4549cfb18)

## [16.4.4] - 2022-03-21

### Changed

- Modernized actions/cache to version 3, which may require users to review their workflow configurations for necessary adjustments to ensure compatibility with the new caching and retrieval behavior during builds. [1f71b1d0](https://github.com/electrocucaracha/openstack-multinode/commit/1f71b1d0023f49952c1b6b15763e80e0ab22c951)

## [16.4.3] - 2022-03-04

### Changed

- Enabled promiscuous mode on AIO nic allowing all traffic to be forwarded to the host in virtualized environments where it has been configured. [3089867b](https://github.com/electrocucaracha/openstack-multinode/commit/3089867bca6493ee3ff8cde99429dab492259dd1)

## [16.4.2] - 2022-03-04

### Changed

- The neutron trunk demo script now uses the config drive to create demo1 server, simplifying the setup process by eliminating the need for manual key injection without breaking existing behavior or requiring migration steps. [11337175](https://github.com/electrocucaracha/openstack-multinode/commit/113371753da0eb807e66fa25075b89e685c13d9e)

## [16.4.1] - 2022-03-04

### Changed

- Simplified Debian-specific removal of python3-cryptography to ensure correct package removal for smooth deployment on these systems. [b28306f3](https://github.com/electrocucaracha/openstack-multinode/commit/b28306f39457acb1afd35f1fc1d0d4661b7b1124)

## [16.4.0] - 2022-03-03

### Added

- Introduced an option to enable autocomplete for the openstack CLI through the undercloud script by adding the --autocomplete flag when running it which adds a new file to the system and may require users to update their bash configuration. [36ea056d](https://github.com/electrocucaracha/openstack-multinode/commit/36ea056d0b753307145790968d1f20dd8fb7d999)

## [16.3.6] - 2022-03-03

### Changed

- Enabled users to connect compute instances directly to physical networks without using tunnels by exposing the enable_neutron_provider_networks variable in the config schema and allowing it to be overridden in environment files or Vagrant configurations. [d95805a0](https://github.com/electrocucaracha/openstack-multinode/commit/d95805a0fa330690bc17b6e315e15a947b6f9e03)

## [16.3.5] - 2022-03-02

### Changed

- Upgraded actions/checkout to version 3, which may affect workflows that rely on this action for checking out code in different environments but does not introduce breaking behavior and requires no migration steps. [dede9b6c](https://github.com/electrocucaracha/openstack-multinode/commit/dede9b6c7a4a84b1796c75edcba19106f221d0b6)

## [16.3.4] - 2022-03-01

### Changed

- Upgraded OpenStack dependencies to new versions of Ansible Core, OpenStack clients, and other libraries across multiple distros including Ubuntu, Debian, CentOS without introducing breaking behavior or requiring migration steps. [be0eacaf](https://github.com/electrocucaracha/openstack-multinode/commit/be0eacafb69b0e18aa05719c6161c3572a53e333)

## [16.3.3] - 2022-03-01

### Changed

- Updated the actions/setup-python action to version 3 which may necessitate re-running setup steps due to potential API contract changes and requires changes to Python versions used in the workflow. [dc8109fb](https://github.com/electrocucaracha/openstack-multinode/commit/dc8109fb085eee14a580917cdaf375ccfeb08e16)

## [16.3.2] - 2022-02-28

### Changed

- Modernized the GitHub Super Linter dependency to version 4.9.0, maintaining compatibility with existing configurations and API contracts without introducing breaking behavior. [f383f2ca](https://github.com/electrocucaracha/openstack-multinode/commit/f383f2ca58e573085768f599fcca9f308c9a082e)

## [16.3.1] - 2022-02-28

### Changed

- Updated the github/super-linter dependency to version 4.8.7, ensuring compatibility with Ubuntu and Debian distributions now set to "3.6.6" in distros_supported.yml. [d9cdb769](https://github.com/electrocucaracha/openstack-multinode/commit/d9cdb769f142db7773fc212886abb9e6051e1d65)

## [16.3.0] - 2022-02-28

### Added

- Enabled detailed hardware statistics for All-in-One deployments, providing users with CPU usage and memory availability information to enhance deployment monitoring and management capabilities without introducing any breaking behavior or migration requirements. [b3d3c830](https://github.com/electrocucaracha/openstack-multinode/commit/b3d3c830565ce262227ba11c62dbe14df2ffbe75)

## [16.2.7] - 2022-02-28

### Changed

- Kolla's OpenStack deployment process has been optimized to improve performance and security through updates to network interface settings, TLS options, and Glance image options, with some configuration schema alterations now using environment variables that may necessitate migration steps for existing deployments. [a996e3eb](https://github.com/electrocucaracha/openstack-multinode/commit/a996e3eb531ba0c1fb1b153804b0469e0d662a9b)

## [16.2.6] - 2022-02-28

### Changed

- Updated dictionary definitions to remove "repo" from OpenStack's word list and upgraded dependencies for OpenStack Kolla to Python 3.10, requiring compatible project requirements files. [9ec1c7dd](https://github.com/electrocucaracha/openstack-multinode/commit/9ec1c7dd9769508a25b5a0ad880167e279ceec53)

## [16.2.5] - 2022-02-28

### Changed

- Upgraded OpenStack Kolla dependencies to improve version stability and ensure compatibility across various components, potentially requiring migration steps for affected users. [2e34c7a4](https://github.com/electrocucaracha/openstack-multinode/commit/2e34c7a4a15f3d7a5c6678c9d340be59bc862607)

## [16.2.4] - 2022-02-28

### Changed

- Updated the GitHub Super Linter dependency to version 4.8.7 from 4.8.5, introducing no breaking behavior or API changes and requiring potential migration steps for users with customized configurations. [0ef1ff71](https://github.com/electrocucaracha/openstack-multinode/commit/0ef1ff7104dcebd644c8589521b5b37e3670cf04)

## [16.2.3] - 2022-02-28

### Changed

- Switched to CentOS Stream distro which is a rolling-release distribution that receives updates directly from Red Hat without the need for major version upgrades impacting how virtual machines are provisioned and configured in Vagrant files with updated commands and settings reflecting the new distro's naming conventions and package versions also affecting registry scripts and configuration files requiring adjustments to accommodate CentOS Stream's unique update cycle. [8138f51e](https://github.com/electrocucaracha/openstack-multinode/commit/8138f51e853893bda631ad4b5e5f475eca5d3369)

## [16.2.2] - 2022-01-27

### Changed

- Stabilized GitHub workflows for linter checks to ensure compatibility with super-linter v4.8.7 by updating environment variables and filter regex exclude paths. [f3726547](https://github.com/electrocucaracha/openstack-multinode/commit/f37265474d70fa1977d71875279284a28c25ed67)

## [16.2.1] - 2022-01-26

### Changed

- Simplified dependency management for Linux distributions by separating requirements files based on distro, enabling more flexible installation and maintenance of dependencies in the undercloud.sh script across CentOS, Debian, and Ubuntu systems. [e6804198](https://github.com/electrocucaracha/openstack-multinode/commit/e6804198524da688faf3c280f93f38f0276bf6d9)

## [16.2.0] - 2022-01-14

### Added

- Enabled contributors to be easily identified and recognized by adding their names in a list, including contribution guidelines and thanks for existing contributors in the README. [0d2ecd46](https://github.com/electrocucaracha/openstack-multinode/commit/0d2ecd46cc0ef1473df5fc816345e1e21042e03c)

## [16.1.7] - 2022-01-03

### Changed

- Updated supported operating systems to match new OpenStack Kolla dependency versions by upgrading CentOS 8, Ubuntu Focal, and Debian Buster to the latest available packages. [6acc0198](https://github.com/electrocucaracha/openstack-multinode/commit/6acc0198eb44a542202dc4b0c95bd8358dd661f2)

## [16.1.6] - 2021-12-29

### Changed

- Optimized hardware resource allocation for controller VMs in No HA CI workflows to improve performance and stability in OpenStack deployments, requiring users to update their workflow configurations accordingly. [06a30123](https://github.com/electrocucaracha/openstack-multinode/commit/06a30123b1cf459bcf80bbf317e5fe779cc54d7d)

## [16.1.5] - 2021-12-29

### Changed

- Optimized pip package installation on compute script to ensure reliable execution regardless of system configuration. [249c251a](https://github.com/electrocucaracha/openstack-multinode/commit/249c251aa86166c34bc29f83758e13d73a1161dc)

## [16.1.4] - 2021-12-29

### Changed

- Config files are now managed using yq tool, replacing manual sed edits in undercloud.sh script and requiring users to adjust their environment variables accordingly for kolla-ansible setup. [3a412bb4](https://github.com/electrocucaracha/openstack-multinode/commit/3a412bb4e26e213fcca5a0df83a2f7d4ccb72909)

## [16.1.3] - 2021-12-28

### Changed

- Enabled the crudini tool for registry configuration management allowing users to set custom values in kolla-build.ini without manual sed commands. [8d43f0e6](https://github.com/electrocucaracha/openstack-multinode/commit/8d43f0e6d5bfde6235f78eee0047a0fead0b3603)

## [16.1.2] - 2021-12-28

### Changed

- Simplified package installation scripts now rely on the PKG_COMMANDS_LIST variable to specify packages that need to be installed, eliminating explicit checks and reducing repetition in several scripts without requiring migration steps due to backwards compatibility. [4be2b93c](https://github.com/electrocucaracha/openstack-multinode/commit/4be2b93cf70a2c6a82aa2599249a3512485e1cae)

## [16.1.1] - 2021-12-28

### Changed

- Upgraded dictionary definitions and dependencies to ensure compatibility with latest Ansible versions, requiring users relying on outdated dependencies to update their configurations accordingly. [e651fe44](https://github.com/electrocucaracha/openstack-multinode/commit/e651fe44ee6375818b7f5b737df6e97277f1018f)

## [16.1.0] - 2021-12-28

### Added

- Enabled monitoring of hardware resources during deployment in the NoHA workflow through additional commands for checking virtual machine statistics and running VMs. [db2f7434](https://github.com/electrocucaracha/openstack-multinode/commit/db2f74346e161c6e3486ae912104579a20ef662a)

## [16.0.2] - 2021-12-28

### Changed

- Optimized Virtualbox configurations to enhance performance by enabling nested paging, large pages, and virtual processor identifiers, customizing the network interface type to virtio, and disabling the GUI for faster boot times with no migration steps required. [d515b94d](https://github.com/electrocucaracha/openstack-multinode/commit/d515b94db14dcaf5f1ae02fee2acec83f8308591)

## [16.0.1] - 2021-12-28

### Changed

- Upgraded GitHub Super Linter to version 4.8.5, preserving the API contract and requiring no migration steps from maintainers or users whose code is analyzed by the updated linter. [7f833090](https://github.com/electrocucaracha/openstack-multinode/commit/7f8330904d04327b55bd33f910613d7adadbcd6b)

## [16.0.0] - 2021-12-28

### Removed

- Simplified installation of the undercloud by eliminating package-specific code for different operating systems, reducing potential breakage during upgrades or migrations and removing errors due to missing packages or unsupported OS versions. [185c0522](https://github.com/electrocucaracha/openstack-multinode/commit/185c0522ccbe9cd1ebbec51caa2c4722ddc4c9fa)

## [15.0.7] - 2021-12-28

### Changed

- The spellchecker's dictionary definitions are now regularly updated to include newly added words and remove misspellings thanks to automated checks introduced by a new CI task. [04bb8d20](https://github.com/electrocucaracha/openstack-multinode/commit/04bb8d20c7cd993b373b829898bc536a653fd5d9)

## [15.0.6] - 2021-12-28

### Changed

- Enabled Neutron trunk demo functionality which requires `OS_KOLLA_ENABLE_NEUTRON_TRUNK` to be set to "yes" for the feature to work and updates undercloud configuration to enable Neutron trunk by default. [e501fe95](https://github.com/electrocucaracha/openstack-multinode/commit/e501fe956b02a9ed4ba6b71518f3b03083b8d0c7)

## [15.0.5] - 2021-11-30

### Changed

- Simplified the aio sample's Vagrantfile by removing hardcoded environment variables and instead using ENV[] lookups where applicable without introducing any breaking behavior or migration requirements. [48068293](https://github.com/electrocucaracha/openstack-multinode/commit/4806829331d8aed4fefd43314b13c0b766f8739c)

## [15.0.4] - 2021-11-30

### Changed

- The CI task now automatically updates requirements.txt to reflect the latest versions of dependencies, including OpenStack Kolla, enabling users who rely on automated dependency updates in their workflows to benefit from these changes without manual intervention. [82438fd0](https://github.com/electrocucaracha/openstack-multinode/commit/82438fd03b4457dce1f12260f609c621bfbb7ede)

## [15.0.3] - 2021-11-24

### Changed

- Enabled a workaround for the VBoxHeadless issue on macOS by conditionally applying it only when running VirtualBox version 6.1.28r147628 or later, thereby preserving compatibility without introducing breaking behavior or API changes and with no security impact. [03208c27](https://github.com/electrocucaracha/openstack-multinode/commit/03208c27d393cdcaca347c317b4e29870b0fb535)

## [15.0.2] - 2021-11-17

### Changed

- Updated github/super-linter to version 4.8.4 which may introduce breaking changes in linter rules and configurations that users should review release notes and changelogs for specific updates. [c220a665](https://github.com/electrocucaracha/openstack-multinode/commit/c220a665032a4addc5ddd723a42f1fcf55f0d63b)

## [15.0.1] - 2021-11-16

### Changed

- Updated the GitHub Super-Linter dependency to version 4.8.3, which may introduce breaking behavior for users who have customized its rules in their workflows. [4e38fbcf](https://github.com/electrocucaracha/openstack-multinode/commit/4e38fbcf1486c99a4d4a432f77822a4ff5c387d9)

## [15.0.0] - 2021-11-12

### Removed

- Simplified the CI configuration to allow testing on any compatible version of Ubuntu Focal without restrictions. [ec072204](https://github.com/electrocucaracha/openstack-multinode/commit/ec0722041e761dab5d923bccd73877e7f6f8b565)

## [14.0.4] - 2021-11-12

### Changed

- Optimized node connectivity within virtualized environments using VirtualBox by replacing static IP configurations with the VBox Internal Networking type for private communication between nodes. [8d320475](https://github.com/electrocucaracha/openstack-multinode/commit/8d320475eaedd8fc64c5665818a8a70823bbdc1c)

## [14.0.3] - 2021-11-12

### Changed

- Optimized GUI behavior on macOS to avoid VBoxHeadless issue by enabling the GUI option in the build process and requiring users to set `v.gui = true` in their Vagrantfiles until a related VirtualBox ticket is resolved. [4338019c](https://github.com/electrocucaracha/openstack-multinode/commit/4338019c928b5baf0e10dcc5868373e725fd8af4)

## [14.0.2] - 2021-11-12

### Changed

- Enabled automated testing of Kolla Docker images on Debian-based systems by integrating the Debian build task into the CI workflow. [ad00c99c](https://github.com/electrocucaracha/openstack-multinode/commit/ad00c99c8cc8a84665633c56d0da19e133a78aee)

## [14.0.1] - 2021-11-01

### Changed

- The list of packages to install is now determined by the PKG_COMMANDS_LIST environment variable, simplifying package management and eliminating repetitive code without requiring any migration steps. [2feb90ee](https://github.com/electrocucaracha/openstack-multinode/commit/2feb90ee0f6d08a69067541f083c9bf589ef2aff)

## [14.0.0] - 2021-11-01

### Removed

- Eliminated RHEL support in AIO affecting users who relied on this distribution requiring migration to supported distributions such as Ubuntu and CentOS. [9996a21b](https://github.com/electrocucaracha/openstack-multinode/commit/9996a21b5b7f2ede55b5f1f223d91f1d89853ff9)

## [13.1.0] - 2021-11-01

### Added

- Enabled HTTP services to consider 429 response codes as valid and interpretable by the system. [a4bb06ef](https://github.com/electrocucaracha/openstack-multinode/commit/a4bb06ef47a6d900b82437c7ccd90bcfe8cf0cd1)

## [13.0.2] - 2021-11-01

### Changed

- Upgraded supported distribution versions to 3.5.0 from 3.4.2 for centos ubuntu debian and rhel without modifying the API contract or introducing security concerns. [91a3ed11](https://github.com/electrocucaracha/openstack-multinode/commit/91a3ed11372501c410d8afc0bb6de5c5e79b3f65)

## [13.0.1] - 2021-10-26

### Changed

- Scripts now enable verbosity by setting the `OS_DEBUG` environment variable to true, allowing for increased logging and debugging output in various scripts, including workflows, deployment tools, and other automation scripts. [e42aafac](https://github.com/electrocucaracha/openstack-multinode/commit/e42aafac7177d875679912fded27044f20332e9b)

## [13.0.0] - 2021-10-26

### Removed

- Simplified configuration by eliminating the need for enable_mariadb_clustercheck variable due to deprecation of wsrep-notify.sh script in Xena Release. [f8c065ad](https://github.com/electrocucaracha/openstack-multinode/commit/f8c065adafab0a6365901b108a4190762d883354)

## [12.3.0] - 2021-10-22

### Added

- Optimized image deployment for OpenStack Control nodes by disabling Kolla build images in NOHA CI due to changes in the workflow configuration which may require manual adjustments to ensure proper image usage without introducing any security vulnerabilities or schema modifications. [cb944a8f](https://github.com/electrocucaracha/openstack-multinode/commit/cb944a8ff2671d2324867ceb1445d4bc82f41c8f)

## [12.2.0] - 2021-10-20

### Added

- NTP daemon validation has been disabled by default in Kolla due to a known bug affecting users who rely on NTP checks during the pre-deployment process and may need to adjust their configuration accordingly. [baac4971](https://github.com/electrocucaracha/openstack-multinode/commit/baac4971d217539168f1818308dfa6eb39083736)

## [12.1.1] - 2021-10-20

### Changed

- Optimized the undercloud installation process by updating dependencies in bindep.txt to include sshpass, pip, gcc, and git. [fbd1d56c](https://github.com/electrocucaracha/openstack-multinode/commit/fbd1d56c9447ab20109fa53f8282edb42062004b)

## [12.1.0] - 2021-10-20

### Added

- Enabled users to run kolla-ansible commands with Ansible's python module by setting the PYTHONPATH environment variable prior to execution. [6e415484](https://github.com/electrocucaracha/openstack-multinode/commit/6e415484f3998288d85c720aaf6194f135f31213)

## [12.0.14] - 2021-10-20

### Changed

- The Neutron external interface selection logic now correctly determines the public network interface based on the presence of the 10.10 network route and requires the OS_KOLLA_NEUTRON_EXTERNAL_INTERFACE config variable to be set. [67fe2504](https://github.com/electrocucaracha/openstack-multinode/commit/67fe2504f151e2f6ae64205f3f2d017a20d543ac)

## [12.0.13] - 2021-10-20

### Changed

- Enabled installation of the testresources Python module for users running tests on Ubuntu systems by updating the CI workflow to include necessary dependencies and package recommendations. [5d37d7a7](https://github.com/electrocucaracha/openstack-multinode/commit/5d37d7a71dc3f0191508093f6368d4e511761737)

## [12.0.12] - 2021-10-20

### Changed

- Updated configuration options and network settings to align with OpenStack Xena release requirements. [35acfb01](https://github.com/electrocucaracha/openstack-multinode/commit/35acfb01209630b43d6d5f198bd066c8cf2582b3)

## [12.0.11] - 2021-10-20

### Changed

- Enabled support for multiple Linux distributions in CI workflows by allowing users to run the same checks on various platforms including Ubuntu and CentOS. [01e40f86](https://github.com/electrocucaracha/openstack-multinode/commit/01e40f86748d9459cf7efe496f6713134bdea9a9)

## [12.0.10] - 2021-10-20

### Changed

- Updated the Docker partition on the Registry VM in Distributed to use disk device sdb instead of sda requiring users to update their configuration manually if they have already set up their distributed environment. [44b50062](https://github.com/electrocucaracha/openstack-multinode/commit/44b5006289720d492f03f779696fbfe793d0580e)

## [12.0.9] - 2021-10-20

### Changed

- Enabled automatic retrieval of missing images from the registry via quay.io or docker pull and push commands to handle cases where images are missing after a build attempt. [c4e87d0f](https://github.com/electrocucaracha/openstack-multinode/commit/c4e87d0fe9ad49afb641380f05d4ea99a93ec8ef)

## [12.0.8] - 2021-10-20

### Changed

- Updated textlint configuration to exclude Node.js terminology from checks resolving issues that arose from this exclusion without introducing breaking behavior or migration requirements. [87a06464](https://github.com/electrocucaracha/openstack-multinode/commit/87a064646e90e17bc8fe253ba3d5e85c3e4fef12)

## [12.0.7] - 2021-10-20

### Changed

- Updated CA certificates are now automatically managed on Ubuntu Control VMs to ensure the latest trusted certificates are used by applications that rely on curl. [6315a3a8](https://github.com/electrocucaracha/openstack-multinode/commit/6315a3a82f6ab8c0baada9cbe744a669e03b7540)

## [12.0.6] - 2021-10-20

### Changed

- The Docker source list removal on Ubuntu Control VM is now correctly handled by the undercloud.sh script without introducing any breaking behavior or security risks. [617ca330](https://github.com/electrocucaracha/openstack-multinode/commit/617ca330632991a800326079310263ecbde80c8d)

## [12.0.5] - 2021-10-20

### Changed

- Modernized kolla-build installation by switching from pip-based package management to direct cloning of the openstack/kolla repository at a specified version, which now requires setting OS_KOLLA_VERSION. [53e19979](https://github.com/electrocucaracha/openstack-multinode/commit/53e19979cce5c953070a7b475650810ea6a1906b)

## [12.0.4] - 2021-10-20

### Changed

- Split CI workflows for No HA deployments into two distinct jobs now require separate runs instead of one combined process necessitating updated configuration and deployment steps. [35a57bee](https://github.com/electrocucaracha/openstack-multinode/commit/35a57bee3adb96d6833d25e8e709f5f48367cf4e)

## [12.0.3] - 2021-10-20

### Changed

- The undercloud script now correctly installs pip packages using the system's pip executable, addressing issues with pip installation in the process. [4c60fb5e](https://github.com/electrocucaracha/openstack-multinode/commit/4c60fb5e97f67ef767279731241cb15a00c0453f)

## [12.0.2] - 2021-10-12

### Changed

- Upgraded to github/super-linter version 4.8.1, which may require migration steps due to the major version update and affects users who rely on the super-linter for code analysis and maintenance tasks. [d163f232](https://github.com/electrocucaracha/openstack-multinode/commit/d163f2327eb07d21e8e72225bd54c496b6248d37)

## [12.0.1] - 2021-10-12

### Changed

- Upgraded the default Kolla build version from 12.0.0 to 12.0.1. [b4a43c0c](https://github.com/electrocucaracha/openstack-multinode/commit/b4a43c0c617dcacc4795c57815b632350c3374b8)

## [12.0.0] - 2021-10-12

### Removed

- Hardened repository security by eliminating insecure keys that could enable unauthorized access and requiring users to generate new SSH keys for authentication. [b960d29c](https://github.com/electrocucaracha/openstack-multinode/commit/b960d29c9268590de05ff54549da7ebf5e38233e)

## [11.5.1] - 2021-10-12

### Changed

- Upgraded pyspelling-any to version 1.0.4, introducing no breaking changes and preserving the existing API contract. [76fcf5c7](https://github.com/electrocucaracha/openstack-multinode/commit/76fcf5c7f551d254c8aa9b604c8af1c5dec9750c)

## [11.5.0] - 2021-10-12

### Added

- Automated dependency updates are now enabled for all GitHub Actions packages across the repository, occurring daily without introducing any breaking behavior and requiring no migration steps. [3cb19a56](https://github.com/electrocucaracha/openstack-multinode/commit/3cb19a56ee5087297827432d27470104a46a3e87)

## [11.4.3] - 2021-09-21

### Changed

- The api_interface config value now requires quotes in the undercloud configuration file to ensure correct API interface settings. [cfc573ea](https://github.com/electrocucaracha/openstack-multinode/commit/cfc573ea49534a1b8fb093c0cd1953f299e0a9b9)

## [11.4.2] - 2021-09-21

### Changed

- Kolla Docker images can now be built and published on CentOS 8 Virtual Machines following the addition of operating system support for this platform. [368e3929](https://github.com/electrocucaracha/openstack-multinode/commit/368e39290e92eecfc74b8da85fb43e8fcf304551)

## [11.4.1] - 2021-09-21

### Changed

- Modernized GitHub CI workflows to introduce new automation and efficiency enhancements for specific scenarios while updating trigger paths and job names. [a999c1cc](https://github.com/electrocucaracha/openstack-multinode/commit/a999c1cc13fe007f8e2fdd3e008aa9b790e9efdb)

## [11.4.0] - 2021-09-21

### Added

- Introduced Neutron's type networks documentation to enable users configure rich network topologies using provider and self-service networks, differentiating them in terms of provisioning, connectivity, and features like DHCP and metadata services relevant for managing complex network configurations. [233e7572](https://github.com/electrocucaracha/openstack-multinode/commit/233e75723ee9b12a300d09c74554dac69e1b9113)

## [11.3.5] - 2021-09-01

### Changed

- Updated the CI job for updating distros to use virtualbox version 3.4.2, ensuring compatibility with the latest virtualbox version and requiring no migration steps from previous versions. [0ac17fe0](https://github.com/electrocucaracha/openstack-multinode/commit/0ac17fe0b11f0ee67a374c5505b8a7d56f32212b)

## [11.3.4] - 2021-08-20

### Changed

- The spellchecker CI action has been optimized to include Markdown files in spelling error checks using the pyspelling-any tool and a project-specific dictionary wordlist. [2344fb72](https://github.com/electrocucaracha/openstack-multinode/commit/2344fb721965738261947a9c38acc3a30534e134)

## [11.3.3] - 2021-08-20

### Changed

- Corrected typos in README files for OpenStack deployment configurations to ensure accurate information is presented to users. [c8337bb2](https://github.com/electrocucaracha/openstack-multinode/commit/c8337bb29609a3afbd5c6cb1fa2629772eb58f2f)

## [11.3.2] - 2021-08-20

### Changed

- Simplified CI cache configuration for GitHub Actions workflows by switching to using the hash of distros_supported.yml instead of Vagrantfile as the key for storing and restoring cached Vagrant boxes. [610d7d47](https://github.com/electrocucaracha/openstack-multinode/commit/610d7d47ca69fc153f129230585dd699c4d98fdb)

## [11.3.1] - 2021-08-20

### Changed

- Updated supported distros to include Ubuntu 20.04 and Debian 10, enabling users to run these versions in their environments without modification. [faf82868](https://github.com/electrocucaracha/openstack-multinode/commit/faf828686c6c41b5ec58ffa6ee1a756bcd72798f)

## [11.3.0] - 2021-08-06

### Added

- The system now allows users to remove Docker repositories in controllers without encountering update conflicts by automatically deleting the conflicting sources.list entry during removal. [a57f27d4](https://github.com/electrocucaracha/openstack-multinode/commit/a57f27d4ee5b4e0f5d51922ca5c97b709c7a5abd)

## [11.2.0] - 2021-08-03

### Added

- Enabled automatic rebasing for the repository by introducing a GitHub Actions workflow triggered by issue comments containing '/rebase', which requires configuration in the repository settings with a GITHUB_TOKEN secret. [ee955d22](https://github.com/electrocucaracha/openstack-multinode/commit/ee955d2228441055644799b3fd487df0b22dc8c0)

## [11.1.2] - 2021-08-03

### Changed

- Optimized On Demand CI jobs to only run on specific file changes, reducing unnecessary job runs and execution time. [eadd6f87](https://github.com/electrocucaracha/openstack-multinode/commit/eadd6f878ccd71076b4528ecaac5e94a9de813fc)

## [11.1.1] - 2021-08-03

### Changed

- Automated distro version updates are now enabled for consistency and reduced maintenance effort. [12e34fb3](https://github.com/electrocucaracha/openstack-multinode/commit/12e34fb3967444341ac78f55f8121204ad57299c)

## [11.1.0] - 2021-08-03

### Added

- Optimized the synced folder type in AIO Vagrantfile to use NFS, requiring users who have customized their setup to adjust their configuration accordingly without affecting the API or CLI contract. [7f3d40d9](https://github.com/electrocucaracha/openstack-multinode/commit/7f3d40d9913ed071b03feae8e5648f8294ec5017)

## [11.0.1] - 2021-07-06

### Changed

- Simplified configuration for distributed environments by removing hardcoded values and updating OS distribution names to match current versions. [3d9b653a](https://github.com/electrocucaracha/openstack-multinode/commit/3d9b653ae6ba474e7b0669931bb6c61317266ba5)

## [11.0.0] - 2021-07-06

### Removed

- Omitted volume files in aio setup, requiring users to manually configure these volumes if they rely on them in their setup. [6db05095](https://github.com/electrocucaracha/openstack-multinode/commit/6db05095b8f34804a961bb4fdc40d338fd1eccd1)

## [10.5.6] - 2021-07-03

### Changed

- Simplified volumes creation in noha setup for easier deployment of OpenStack nodes by eliminating custom disk creations and streamlining the setup process without introducing any breaking behavior or migration requirements. [f29d528f](https://github.com/electrocucaracha/openstack-multinode/commit/f29d528f94f0269154ac40ce8f71289e5163e28e)

## [10.5.5] - 2021-07-03

### Changed

- Updated Vagrantfile behavior now omits autogenerated files and modifies inventory file creation to ensure compatibility with existing configurations that relied on these specific behaviors. [33ff9c90](https://github.com/electrocucaracha/openstack-multinode/commit/33ff9c9012353ba624de4b6166bcd4aa27fea8e8)

## [10.5.4] - 2021-07-03

### Changed

- Simplified the on-demand NOHA deployment process in GitHub Actions by updating job names, adjusting deployment steps, and modifying environment variable settings without introducing breaking behavior or requiring migration steps. [d635026d](https://github.com/electrocucaracha/openstack-multinode/commit/d635026d1e554e83488bd0a8969a50385b987034)

## [10.5.3] - 2021-07-02

### Changed

- Enabled chrony services by default, reversing their disabled state in the Wallaby release and requiring users to adjust their configuration accordingly if they rely on chrony for time synchronization. [1bc99e81](https://github.com/electrocucaracha/openstack-multinode/commit/1bc99e818c60db8ab7faea72c86fd9a1eca88446)

## [10.5.2] - 2021-07-02

### Changed

- Controller nodes in the noha CI workflow now require 2 CPUs instead of 1 to improve performance, and the config schema has been updated accordingly without requiring any migration steps. [b3714ee0](https://github.com/electrocucaracha/openstack-multinode/commit/b3714ee0ff623ec80bf1a6baab19dc236ddd7ee0)

## [10.5.1] - 2021-07-02

### Changed

- Enabled new deployment workflows by introducing experimental Vagrant functionality that can be utilized by setting the VAGRANT_EXPERIMENTAL environment variable and updating configuration accordingly. [57d8fa23](https://github.com/electrocucaracha/openstack-multinode/commit/57d8fa23036fc89ac3b33779621cd240c848fd83)

## [10.5.0] - 2021-07-02

### Added

- Enabled better utilization of virtualization features in aio samples by configuring UART settings and enabling nested paging, large pages, and virtual processor identifiers for performance optimization without introducing breaking behavior but requiring users to update their Vagrantfiles accordingly. [d32f03f8](https://github.com/electrocucaracha/openstack-multinode/commit/d32f03f8d84d6b2626a300005c8839e2326e9aee)

## [10.4.2] - 2021-07-02

### Changed

- clarified hardware requirements for OpenStack services deployment by explicitly mentioning Intel's NUC 10 Performance kit and providing environment variables for customizing cluster settings. [f33e058c](https://github.com/electrocucaracha/openstack-multinode/commit/f33e058cbf63fddd8eccbc6dad1aec4eb3e1012c)

## [10.4.1] - 2021-07-02

### Changed

- Updated documentation to reflect hardware configuration changes using Raspberry Pi 4 Model B instead of Intel's NUCs. [5de6d636](https://github.com/electrocucaracha/openstack-multinode/commit/5de6d636768bddfe9881705d6d69874eaf9947a1)

## [10.4.0] - 2021-07-02

### Added

- Enabled persistence of OS variables in controller for noha deployments, requiring users to adapt their configurations and export environment variables to /etc/environment during deployment. [cf562d3a](https://github.com/electrocucaracha/openstack-multinode/commit/cf562d3a96e9fac62c1d0dd2075ce1458a59f03b)

## [10.3.4] - 2021-07-02

### Changed

- Optimized the Kolla build process to allocate one CPU for building and adjust thread counts based on available CPUs, resulting in increased efficiency and reliability. [cc7d0d6a](https://github.com/electrocucaracha/openstack-multinode/commit/cc7d0d6ad2f42e348c68318dfb5b983841c0d25b)

## [10.3.3] - 2021-07-01

### Changed

- Enabled experimental features from iproute2mac and Vagrant for on-demand NoHA setup by requiring users to set the `VAGRANT_EXPERIMENTAL` environment variable when using Vagrant with NoHA. [7f2f4fc2](https://github.com/electrocucaracha/openstack-multinode/commit/7f2f4fc22399d1796105f1df39563bd9f3f33326)

## [10.3.2] - 2021-07-01

### Changed

- Simplified pip3 softlink creation by removing conditional checks for its existence and directly creating the link if it does not exist resulting in a more straightforward script with equivalent behavior. [be5fc39a](https://github.com/electrocucaracha/openstack-multinode/commit/be5fc39a7cc94e3fb92d81bc7f0b429fdc7496fb)

## [10.3.1] - 2021-07-01

### Changed

- Updated GitHub actions workflow configurations to run on demand and triggered by both push and pull request events requiring users to update their workflow configurations accordingly. [2105695d](https://github.com/electrocucaracha/openstack-multinode/commit/2105695d3aba1ba9da0218ab836ecb76d06946a6)

## [10.3.0] - 2021-07-01

### Added

- Optimized kolla build performance by automatically configuring threads based on available system resources. [0eddd623](https://github.com/electrocucaracha/openstack-multinode/commit/0eddd623731d24df1270d0548c063c250d434e6f)

## [10.2.6] - 2021-07-01

### Changed

- Modernized the no High Availability (HA) sample configuration to work correctly with latest Ubuntu versions. [7bea1662](https://github.com/electrocucaracha/openstack-multinode/commit/7bea1662b6739ae4190f628b7cd985d0252b228c)

## [10.2.5] - 2021-07-01

### Changed

- Upgraded dependencies to be managed through git instead of tarballs allowing for smoother updates and easier maintenance. [93130c53](https://github.com/electrocucaracha/openstack-multinode/commit/93130c53c55d90976deeff8199a7d8a1cdf011f6)

## [10.2.4] - 2021-07-01

### Changed

- Enabled customization of internal VIP addresses for OpenStack deployments through the install script's configuration settings. [5a005c4e](https://github.com/electrocucaracha/openstack-multinode/commit/5a005c4e612c055660477c95026ba1cf79eadb43)

## [10.2.3] - 2021-07-01

### Changed

- Updated Kolla build instructions to switch from centos8-master to centos8-wallaby base architecture and updated related configurations. [5ab335ec](https://github.com/electrocucaracha/openstack-multinode/commit/5ab335ecc9424bdb8f2e2e83110c81d116181d22)

## [10.2.2] - 2021-07-01

### Changed

- Updated kolla version to 12.0.0 and modified autodiscover base distro in registry.sh to dynamically set the OS_KOLLA_BASE variable based on the current Linux distribution ID, requiring users with outdated installations to update their configurations accordingly. [d334555b](https://github.com/electrocucaracha/openstack-multinode/commit/d334555be4ea448fdcc3a44636abcaa85787c745)

## [10.2.1] - 2021-07-01

### Changed

- Updated the list of supported distributions to include version 3.2.20 for centos 8, ubuntu focal, debian buster, and rhel 8, while dropping support for ubuntu bionic and centos 8 version 3.2.18, requiring potential migration steps to ensure compatibility with the updated versions. [4fadb3df](https://github.com/electrocucaracha/openstack-multinode/commit/4fadb3dfb0283f72b500d73295bd0ce9dacb29ce)

## [10.2.0] - 2021-07-01

### Added

- Enabled node-specific dependency installation during setup, allowing users to specify their Node environment requirements without manual intervention for existing configurations. [60dac773](https://github.com/electrocucaracha/openstack-multinode/commit/60dac7738973392fb0e710b3f763dbd7d5282dfc)

## [10.1.7] - 2021-07-01

### Changed

- Compute instructions now support installation on multiple Linux distributions, including Debian-based systems, without requiring manual configuration. [6fd44a29](https://github.com/electrocucaracha/openstack-multinode/commit/6fd44a298c9fd7591ca9b351880f60314df3a915)

## [10.1.6] - 2021-06-01

### Changed

- Migrated CI workflows to GitHub Actions, resulting in improved automation and reduced infrastructure costs for users without requiring any migration steps. [a3937885](https://github.com/electrocucaracha/openstack-multinode/commit/a3937885cd0525053c767908aa92a2eb1ab1a851)

## [10.1.5] - 2021-05-10

### Changed

- Updated sample deployment scripts to resolve linting and broken links issues, including updating the Horizon dashboard URL for aio and noha samples and removing the Skydive service link due to its obsolescence. [853cdce9](https://github.com/electrocucaracha/openstack-multinode/commit/853cdce98783d141a626f5476c363947e0e56d98)

## [10.1.4] - 2021-05-10

### Changed

- Modernized GitHub Actions workflows to split deployment and build processes into separate jobs in the new `deploy.yml` file and introduced a job to check broken links in Markdown files. [9ae1c05a](https://github.com/electrocucaracha/openstack-multinode/commit/9ae1c05a0defaa42a59d230e0419ea6f54b0687a)

## [10.1.3] - 2021-05-10

### Changed

- Updated the supported vagrant box version to 3.2.18 without introducing any breaking behavior and no migration steps are required. [7d165591](https://github.com/electrocucaracha/openstack-multinode/commit/7d165591b1b370e5d4ad247bf61a12341d885da7)

## [10.1.2] - 2021-05-10

### Changed

- Modernized kolla-ansible to Wallaby release requiring users to review and adjust their configuration files for Octavia load balancer settings and healthcheck configurations. [57360e22](https://github.com/electrocucaracha/openstack-multinode/commit/57360e22d7e513c12ce92dcbd73ad399e04ba2a7)

## [10.1.1] - 2021-04-13

### Changed

- Enabled OS selection in AIO setup allowing users to choose their preferred operating system distribution from the environment variable `OS_DISTRO` without changing the default OS and requiring no migration steps. [d6a7ff2d](https://github.com/electrocucaracha/openstack-multinode/commit/d6a7ff2de1fde14b47d1906e6a0327e243ce8b44)

## [10.1.0] - 2021-04-13

### Added

- TravisCI builds now reuse cached copies of downloaded images for Vagrant users, reducing build time and eliminating large downloads on subsequent runs if a matching image is already cached. [6c31816f](https://github.com/electrocucaracha/openstack-multinode/commit/6c31816f7448d55ae24a94be558e4861397d6c65)

## [10.0.0] - 2021-04-12

### Removed

- Eliminated support for BareMetal deployment on TravisCI affecting users who relied on this method for testing and requiring migration of existing configurations to Vagrant for CentOS 8 validation instead. [696e68e1](https://github.com/electrocucaracha/openstack-multinode/commit/696e68e1a3e7659ca97d26c4a4a19347fcc652a8)

## [9.0.0] - 2021-04-12

### Removed

- Eliminated reliance on TravisCI for build image processing affecting users who must now manually handle tasks related to OpenStack Kolla images validation and registry configuration. [f362cfe6](https://github.com/electrocucaracha/openstack-multinode/commit/f362cfe63256cc47b24ca0cb41b7abac06f5ccc3)

## [8.6.2] - 2021-04-12

### Changed

- Upgraded build version to 11.0.0, impacting configuration settings in kolla-build.ini and changing the tag for Docker images from 9.1.0 to 11.0.0 with a default thread count of 8 for pushing images. [c3866ee2](https://github.com/electrocucaracha/openstack-multinode/commit/c3866ee25b4b91d9ba1f105dfaa57f806a53844c)

## [8.6.1] - 2021-04-12

### Changed

- Upgraded vagrant box versions for supported distributions to 3.2.10, which may break existing VMs if they rely on the previous version and requires users to update their environments accordingly. [6ef5bcea](https://github.com/electrocucaracha/openstack-multinode/commit/6ef5bceaa41fc70c2110596fc574e1bdc849a4a6)

## [8.6.0] - 2021-04-12

### Added

- Enabled code quality checks through integration of Reviewdog Github action triggered on push to master branch requiring configuration of a github token secret for automated review and feedback. [6652d2ea](https://github.com/electrocucaracha/openstack-multinode/commit/6652d2eacf28fec0751f72483020ace57173ee23)

## [8.5.1] - 2021-04-12

### Changed

- Updated kolla-ansible to version 10.2.0, enabling users to leverage new features and bug fixes without requiring configuration adjustments or migration steps. [536c5329](https://github.com/electrocucaracha/openstack-multinode/commit/536c532902559995c844a0391d30039aa3e48f8a)

## [8.5.0] - 2021-04-12

### Added

- Automated workflows are now enabled within repositories through Github custom actions, introducing a new CI/CD pipeline that checks bare-metal installations and builds images on push events to the master branch with Ubuntu 18.04 as the base image and including steps for deploying services and validating images, requiring migration with no breaking behavior or security impact noted. [0e494008](https://github.com/electrocucaracha/openstack-multinode/commit/0e494008958840bbbf7e14ae72c3c982dcd337f7)

## [8.4.2] - 2021-04-12

### Changed

- Improved super-linter functionality by updating GitHub Actions to leverage the latest version and enhanced configuration settings. [aea182d2](https://github.com/electrocucaracha/openstack-multinode/commit/aea182d2843c259d7a3cba4c0b9cfc54f80d8c20)

## [8.4.1] - 2020-10-20

### Changed

- Enabled Magnum cluster setup during installation by default, requiring users to configure the OS_KOLLA_ENABLE_MAGNUM environment variable in their deployment settings for automatic handling. [9c396f04](https://github.com/electrocucaracha/openstack-multinode/commit/9c396f04ea1d4dd1e8f897f959dc1a55bb3506c7)

## [8.4.0] - 2020-10-20

### Added

- Enabled users to manage virtual machines directly from the command line on RHEL, CentOS, and Fedora systems by installing virsh client tools on compute nodes. [40730281](https://github.com/electrocucaracha/openstack-multinode/commit/407302814eed3571e1906b67d3ca7b3b36faea2d)

## [8.3.0] - 2020-10-20

### Added

- Enabled persistent veth0 pair connections for aio sample setups without introducing any breaking behavior, allowing network interfaces to remain available after virtual machine reboots. [6d7e5c58](https://github.com/electrocucaracha/openstack-multinode/commit/6d7e5c585a76493efbe09ff036d81968113f29d7)

## [8.2.2] - 2020-10-20

### Changed

- Optimized Kolla's automated build process for users relying on it by enabling image optimization through the installation of the docker-squash package and introducing configuration changes to increase thread count, retries, and cache usage. [6b8c1e7e](https://github.com/electrocucaracha/openstack-multinode/commit/6b8c1e7eb8867c88e0a11bfc8225cd8daef6efe5)

## [8.2.1] - 2020-10-20

### Changed

- Upgraded Vagrant environments to utilize CentOS base images by default, replacing Ubuntu as the default base distribution and potentially requiring users to update their environment settings accordingly. [cb9c30ee](https://github.com/electrocucaracha/openstack-multinode/commit/cb9c30ee2b0143b6b5b1ab13b1a917698e39c83c)

## [8.2.0] - 2020-10-20

### Added

- Enabled iSCSI volume types by default in Cinder configuration and loaded necessary kernel modules for LVM and target-core-mod during node setup, resolving issues with loading kernel modules that affected users relying on these features. [a1aafc01](https://github.com/electrocucaracha/openstack-multinode/commit/a1aafc01d4a8df9fbe2fa11f2e43512b34681ce9)

## [8.1.0] - 2020-10-20

### Added

- Enabled All-in-One VMs to utilize the linuxbridge neutron agent by default instead of openvswitch, impacting network configuration without altering the API or CLI contract and requiring no migration steps. [ec8605f4](https://github.com/electrocucaracha/openstack-multinode/commit/ec8605f4ad5cbb7ec5017b192b1833c53d6ca77b)

## [8.0.3] - 2020-10-20

### Changed

- Magnum service is now disabled by default in Kolla, affecting users who rely on Magnum for container orchestration and requiring manual enablement if its functionality is needed. [c5940ddd](https://github.com/electrocucaracha/openstack-multinode/commit/c5940dddaa1a33971c5b17fe8e0adb03f4353452)

## [8.0.2] - 2020-10-20

### Changed

- Optimized TravisCI execution by updating validation configurations and registry settings to improve build efficiency. [e42341db](https://github.com/electrocucaracha/openstack-multinode/commit/e42341dbe442285124bc7f988f59aa5ffdc671c8)

## [8.0.1] - 2020-10-19

### Changed

- Updated All-in-One (AIO) deployments to default to CentOS 8 instead of Ubuntu, impacting users who rely on AIO for testing OpenStack environments with minor adjustments made to network configuration and package management. [08a400c6](https://github.com/electrocucaracha/openstack-multinode/commit/08a400c6b31fc988f40571f1423d9847bc188d3d)

## [8.0.0] - 2020-10-19

### Removed

- Cockpit installation in nodes has been eliminated, requiring users to manually remove Cockpit services if previously installed. [169238bb](https://github.com/electrocucaracha/openstack-multinode/commit/169238bb1a9c61ea29e02c8b9b0ceb3010c21d9a)

## [7.0.0] - 2020-10-19

### Removed

- Simplified the installation process by eliminating unnecessary configuration options in install.sh. [2f2471ca](https://github.com/electrocucaracha/openstack-multinode/commit/2f2471ca61b0ad7d39987185d3517c6757d82ed1)

## [6.2.6] - 2020-10-19

### Changed

- Updated the list of supported Linux distributions to reflect the current matrix from openstack.org, now including Debian 10 and RHEL 8 as valid options for Kolla-Ansible deployments. [4da4f5ec](https://github.com/electrocucaracha/openstack-multinode/commit/4da4f5ec67eca22a0add55a1076633ae1365dad9)

## [6.2.5] - 2020-10-18

### Changed

- Migrated over 100 packages from trunk.rdoproject.org to openstack directories in the registry.sh script for the Victoria release. [7868fa44](https://github.com/electrocucaracha/openstack-multinode/commit/7868fa44e39c0a62677db6c5552cb226333df81d)

## [6.2.4] - 2020-10-17

### Changed

- Upgraded scripts to now rely on the Victoria release of OpenStack instead of Ussuri, requiring users to update their configuration accordingly due to changes in registry port and OpenStack version configuration. [372ab590](https://github.com/electrocucaracha/openstack-multinode/commit/372ab590a81d560bbfdf21a49155bdc79db8d572)

## [6.2.3] - 2020-10-17

### Changed

- Updated the list of supported Linux distributions to include new versions for CentOS 8, Ubuntu 20.04, and OpenSUSE 42 while removing outdated entries which may require users to update their configurations or scripts that rely on the previous distribution information. [ee11c6b9](https://github.com/electrocucaracha/openstack-multinode/commit/ee11c6b91274be94cd5e4f06ee26c1f17ac4de14)

## [6.2.2] - 2020-07-06

### Changed

- Upgraded the kolla-ansible project to the Ussuri release, changing default openstack_release from train to ussuri and impacting container image tags and Docker registry settings. [a9772e78](https://github.com/electrocucaracha/openstack-multinode/commit/a9772e7807b52d492c27a4fcba4a278c102efba4)

## [6.2.1] - 2020-07-06

### Changed

- Travis CI execution has been optimized by updating the configuration to use a newer version of Ubuntu and specifying a Python version, resulting in no migration steps required and unchanged API or CLI contracts. [183a899c](https://github.com/electrocucaracha/openstack-multinode/commit/183a899c64133b3538a4821fc64ecb568304ca90)

## [6.2.0] - 2020-07-06

### Added

- Enabled GitHub Linter actions to validate code on push to the master branch, checking for syntax errors and other issues in Bash scripts while using the super-linter action with version 2.0.0 and disabling Bash validation. [8e77d318](https://github.com/electrocucaracha/openstack-multinode/commit/8e77d3188aaf337579e5b83d91813786117e0691)

## [6.1.8] - 2020-04-09

### Changed

- Corrected the typo in PKG_UDPATE to PKG_UPDATE without introducing any breaking behavior or requiring changes from users who rely on the install_pkg script for package management. [f421ac33](https://github.com/electrocucaracha/openstack-multinode/commit/f421ac331aefae3606417f1e87d2728524ed57c4)

## [6.1.7] - 2020-03-25

### Changed

- Simplified SSH setup instructions in AIO Vagrantfile to reduce the number of commands and improve security by using more secure methods for generating and copying SSH keys without introducing any breaking behavior but may require manual cleanup of existing SSH key files before running the updated provisioning script. [89a413c5](https://github.com/electrocucaracha/openstack-multinode/commit/89a413c54088aac667686c33da20b22a810a3bb8)

## [6.1.6] - 2020-03-25

### Changed

- The all-in-one deployment configuration for OpenStack services has been updated to use Ubuntu Bionic instead of CentOS 7, affecting the underlying operating system and package management, requiring users to adapt their development environments and possibly adjust Vagrantfile configurations. [915a9772](https://github.com/electrocucaracha/openstack-multinode/commit/915a97721a41b322fdc324f2bf5d02fe15a13ee7)

## [6.1.5] - 2020-03-23

### Changed

- The AIO installation script now accepts an optional environment variable OS_KOLLA_NETWORK_INTERFACE allowing users to specify the network interface for Kolla deployment thereby enabling customization of the network configuration during installation. [63581c5e](https://github.com/electrocucaracha/openstack-multinode/commit/63581c5e7dcbfe70b623e1bb307af6183bf221c9)

## [6.1.4] - 2020-03-23

### Changed

- Environment variables are now correctly set during installation by directly exporting OS_ prefixed variables into /etc/environment, eliminating potential inconsistencies in environment settings and requiring no further action from users or maintainers. [80bd4285](https://github.com/electrocucaracha/openstack-multinode/commit/80bd4285ec3571e5a4aa18eacbc5501085d5fdc8)

## [6.1.3] - 2020-03-21

### Changed

- Clarified project documentation by including license information and Vagrant configuration instructions in sample directories to provide users with clear licensing details and improved usability. [f5098035](https://github.com/electrocucaracha/openstack-multinode/commit/f50980351c15a278b1f33d1ebddeb89cf84baea7)

## [6.1.2] - 2020-03-21

### Changed

- Normalized VirtualBox volume sizes to be specified in kilobytes for consistency, potentially impacting users who manually set volume sizes in Vagrantfile configurations. [80080fd7](https://github.com/electrocucaracha/openstack-multinode/commit/80080fd7e4066cc97a9218b4ecfef29b51d8a99c)

## [6.1.1] - 2020-03-21

### Changed

- Vagrant-based deployments now successfully install and operate on devices previously reported as busy by reassigning the device to /dev/sdc instead of /dev/sdb. [1783f2d1](https://github.com/electrocucaracha/openstack-multinode/commit/1783f2d1ca867dbb6f6fc6561e1ec216ec7de5c5)

## [6.1.0] - 2020-03-21

### Added

- Optimized repository tracking by excluding VirtualBox Disk Image files from being stored in the repository's history. [52195973](https://github.com/electrocucaracha/openstack-multinode/commit/52195973bf101ff6a0c7877dd1d7d87b699d04dd)

## [6.0.6] - 2020-03-21

### Changed

- The local Docker registry is now optional, enabling users to choose between using the built-in registry and a separate one without introducing any breaking behavior or API changes. [ac221a27](https://github.com/electrocucaracha/openstack-multinode/commit/ac221a27950d7f780496f8d1b21514113e76a5b4)

## [6.0.5] - 2020-03-20

### Changed

- Enhanced documentation to include specific diagrams for distributed configurations, replacing the generic previous version and directly linking from the distributed configuration sample's README. [1cf89bbd](https://github.com/electrocucaracha/openstack-multinode/commit/1cf89bbdd66266c863b10a8a8c4d38c72a9ccd13)

## [6.0.4] - 2020-03-18

### Changed

- Optimized distributed configuration to improve performance and reduce resource usage by adjusting memory allocations for nodes and CPU counts accordingly without introducing any breaking behavior or migration requirements. [0e2a96d0](https://github.com/electrocucaracha/openstack-multinode/commit/0e2a96d057b6b4805de71cbdb58233084c451524)

## [6.0.3] - 2020-03-18

### Changed

- Modernized documentation to reflect the shift from package-based management to container-based systems, highlighting benefits including OS-agnostic deployment, easy scaling, fast deployment, and self-healing capabilities, with CentOS 7 now used in All-in-One configurations instead of Ubuntu Xenial. [ba22fe82](https://github.com/electrocucaracha/openstack-multinode/commit/ba22fe82441bd6a0a397218da6216f04238d0084)

## [6.0.2] - 2020-03-18

### Changed

- Optimized AIO configurations to use the kolla external VIP interface and a more permissive SELinux policy by default, while disabling IPv6 on systems that support it, requiring users to update their network settings accordingly. [bcc3207d](https://github.com/electrocucaracha/openstack-multinode/commit/bcc3207db9a52c0b6029550e526373809e1607e1)

## [6.0.1] - 2020-03-18

### Changed

- Updated VirtualBox support to ensure compatibility with the latest releases of CentOS, Ubuntu, and OpenSUSE by adjusting controller settings in Vagrantfiles for these distributions. [989a419f](https://github.com/electrocucaracha/openstack-multinode/commit/989a419fe8302ef3035939acd0c0498bf1010cf4)

## [6.0.0] - 2020-03-17

### Removed

- Simplified installation process by eliminating unnecessary steps that were previously required to configure the environment. [9b7cfd32](https://github.com/electrocucaracha/openstack-multinode/commit/9b7cfd32a6270aad60a413310c9337d7f4f9f8d1)

## [5.4.3] - 2020-03-17

### Changed

- The node setup process now automatically installs cURL on Ubuntu systems, enabling the execution of curl commands without requiring manual package installation. [c4d6ae1d](https://github.com/electrocucaracha/openstack-multinode/commit/c4d6ae1d6607c4f2f9513f58b217b7a978ad41fa)

## [5.4.2] - 2020-03-16

### Changed

- Enabled default services and updated supported OpenStack releases in globals.yml configuration files to train and reflect current service availability. [6be30423](https://github.com/electrocucaracha/openstack-multinode/commit/6be3042344fc5e718296fd11b02e7b0c43bcf745)

## [5.4.1] - 2020-03-09

### Changed

- Enabled network connectivity for Vagrant environments by introducing virtual Ethernet interface veth0 and setting up bridge uplinkbridge, requiring no migration steps or security impact. [abcadd1d](https://github.com/electrocucaracha/openstack-multinode/commit/abcadd1d4f21df810151b8b52f52bc7e1883f393)

## [5.4.0] - 2020-03-07

### Added

- Cockpit services are now enabled by default, allowing users to access system monitoring and management tools through a web interface without requiring manual migration for existing installations that relied on custom service installation procedures. [e2f41d57](https://github.com/electrocucaracha/openstack-multinode/commit/e2f41d57b3590c0a9d0e807d68c1f9977067e6cf)

## [5.3.5] - 2020-03-06

### Changed

- Enabled cinder service in no HA configuration allowing for the creation of Cinder volumes on compute nodes without requiring high availability setup. [f86736d0](https://github.com/electrocucaracha/openstack-multinode/commit/f86736d0df456106590bfe3ca52c6868a45e43d1)

## [5.3.4] - 2020-03-06

### Changed

- Optimized external VIP address assignment behavior by updating Kolla_external_vip_interface value to default to the management network interface, requiring users to review their configuration files for alignment with new settings. [73ccf727](https://github.com/electrocucaracha/openstack-multinode/commit/73ccf727159e97be30d27edaa99341a16ba5a40a)

## [5.3.3] - 2020-03-04

### Changed

- Kolla-build.ini configuration now defaults to skipping existing images by default for faster rebuilds when the image cache is intact. [f203ab31](https://github.com/electrocucaracha/openstack-multinode/commit/f203ab312896983f993da7eb84f86a2eba14add9)

## [5.3.2] - 2020-03-02

### Changed

- Enabled Cinder volumes for use in Magnum clusters, allowing users to test Kubernetes deployments with this storage backend. [42492b16](https://github.com/electrocucaracha/openstack-multinode/commit/42492b1651513465194f2093766cc684f4029306)

## [5.3.1] - 2020-02-28

### Changed

- Updated the Vagrantfile for the noha sample to reflect changes in hardware specifications and processor details, enabling users to set up this environment with accurate settings. [db3b7a5a](https://github.com/electrocucaracha/openstack-multinode/commit/db3b7a5a146b4af4c931f04c80b725f06783891c)

## [5.3.0] - 2020-02-28

### Added

- Enabled SELinux validation during installation, requiring users to configure their system in Permissive mode for successful setup and prompting adjustments to the /etc/selinux/config file for those with Enforcing mode enabled. [1da35555](https://github.com/electrocucaracha/openstack-multinode/commit/1da3555539032201af613d726b381a58d8ee286c)

## [5.2.2] - 2020-02-28

### Changed

- Stabilized compatibility on Ubuntu Bionic systems by updating scripts to utilize per-user site-packages directories as specified in PEP 370. [bba3d5a9](https://github.com/electrocucaracha/openstack-multinode/commit/bba3d5a935504d71086a240e874bda62f456a51b)

## [5.2.1] - 2020-02-27

### Changed

- Enabled management of container clusters within OpenStack environments through integration of the Magnum service into default images provided by Kolla. [8c193a45](https://github.com/electrocucaracha/openstack-multinode/commit/8c193a457fb98071624d9279f458c7059656e9a9)

## [5.2.0] - 2020-02-27

### Added

- Enabled CPU and RAM overcommitting by default, allowing users to allocate more resources than are physically available in the system, with cpu_allocation_ratio and ram_allocation_ratio settings initially set to 16.0 and 1.5 respectively. [29e21764](https://github.com/electrocucaracha/openstack-multinode/commit/29e21764b5da26302253e51579da1fa6a919b945)

## [5.1.14] - 2020-02-27

### Changed

- Updated the undercloud setup script to resolve AIO issues by modifying dependencies, configuration files, and Ansible settings, and also introduced a new command to generate passwords for the undercloud setup. [2360e542](https://github.com/electrocucaracha/openstack-multinode/commit/2360e542a65a28785b903c4ec6d9382f8a41c6f2)

## [5.1.13] - 2020-01-15

### Changed

- The IP management discovery method has been modernized to use the public DNS service for determining the management network interface and IP address instead of relying on IP routing tables. [4cd09097](https://github.com/electrocucaracha/openstack-multinode/commit/4cd090978c7f3785106258e04c603f42fe0912d7)

## [5.1.12] - 2020-01-12

### Changed

- Redefined project structure impacting deployment configurations for All-in-One, No High Availability, and Distributed setups, requiring users to update their deployment scripts and configurations accordingly. [8a8b5603](https://github.com/electrocucaracha/openstack-multinode/commit/8a8b560319e2709e85e7b39f56f54360fb769908)

## [5.1.11] - 2020-01-08

### Changed

- The undercloud provisioning script was modernized to simplify deployment and ensure compatibility with newer versions of Kolla-Ansible by removing deprecated variables, updating the inventory format, adjusting configuration settings for various OpenStack services, and refactoring the undercloud.sh script to use more modern installation methods. [1f38e4ce](https://github.com/electrocucaracha/openstack-multinode/commit/1f38e4ce93d86eec6bc58224d637fa731b36b6e9)

## [5.1.10] - 2020-01-08

### Changed

- Simplified the node's provisioning script to remove proxy setup and modified logging for certain roles, potentially impacting system state after running the script if purge commands are executed. [befbdc37](https://github.com/electrocucaracha/openstack-multinode/commit/befbdc3759cb3f84ee67a46cd4f60d17a8b2abeb)

## [5.1.9] - 2020-01-08

### Changed

- Optimized registry bash script functionality to allow dynamic OpenStack release and branch specification in configuration files for Horizon plugins, Neutron services, and other affected projects. [2652d5e8](https://github.com/electrocucaracha/openstack-multinode/commit/2652d5e89c17d709cdb0e0c7150a3463cae247f5)

## [5.1.8] - 2020-01-07

### Changed

- The node.sh script has been streamlined to correctly handle AMD-based systems and now enables vhost_net by removing unnecessary configuration steps and vendor-specific code. [914566cd](https://github.com/electrocucaracha/openstack-multinode/commit/914566cdba2335f7cfc475f0879502b8173eeade)

## [5.1.7] - 2020-01-07

### Changed

- Updated shellcheck issues were resolved by updating the `wget` commands to use double quotes around URLs in the registry.sh and undercloud.sh scripts, ensuring secure file retrieval practices without breaking any behavior or affecting API or CLI contracts. [90a7caf3](https://github.com/electrocucaracha/openstack-multinode/commit/90a7caf30ab51c216a4bca7d38601a054218616a)

## [5.1.6] - 2020-01-07

### Changed

- Enabled customization of the Ansible user used for deployment by allowing specification via environment variable or new config option. [8721cd77](https://github.com/electrocucaracha/openstack-multinode/commit/8721cd77d80b15f86a9d501c1a76b90e87f8d603)

## [5.1.5] - 2020-01-07

### Changed

- Migrated Kolla log folder from /var/log/kolla to /tmp/kolla, requiring scripts and users to update their references to the new location. [4ba1721a](https://github.com/electrocucaracha/openstack-multinode/commit/4ba1721a17d2af13211500d67841cb92997eaaf8)

## [5.1.4] - 2020-01-07

### Changed

- Configured support for different Linux distributions through environment variables to enable more flexible configuration of supported distros. [3fe296cd](https://github.com/electrocucaracha/openstack-multinode/commit/3fe296cdb73370747c03e746cc9fccd9df107e28)

## [5.1.3] - 2020-01-07

### Changed

- The kolla-ansible settings for an All-in-One OpenStack configuration now default to using a specific network interface and IP addresses for management, API, and external networks, with HAProxy enabled by default unless the external VIP address matches the management IP address. [3d3612fd](https://github.com/electrocucaracha/openstack-multinode/commit/3d3612fdaedea9fd717359cf3a82ad9efbb5872d)

## [5.1.2] - 2020-01-07

### Changed

- Updated the OpenStack Release version to be exported, requiring manual updates to existing configurations that hardcoded the release version for consistency across components such as Vagrant provisioning, undercloud setup, and registry configuration. [33a94073](https://github.com/electrocucaracha/openstack-multinode/commit/33a9407348c4bcbe7c823c0d85895b196fe56da0)

## [5.1.1] - 2020-01-07

### Changed

- The registry provisioning script has been modernized to support different Linux distributions and versions of Kolla, allowing for streamlined Docker installation and configuration with customizable proxy settings and insecure registries. [0cbf3156](https://github.com/electrocucaracha/openstack-multinode/commit/0cbf3156a8e21c6d74f62eff74f795ba97116589)

## [5.1.0] - 2020-01-07

### Added

- Enabled users to test and experiment with non-high-availability deployment scenarios through the addition of a sample configuration including Vagrant files and hosts.ini templates defining compute nodes, controller node, and network settings. [05a82f79](https://github.com/electrocucaracha/openstack-multinode/commit/05a82f7963765ca1bdf6e341374eac6f0c6f9fba)

## [5.0.0] - 2020-01-07

### Removed

- Simplified initial setup instructions by directing users to leverage the bootstrap-vagrant project's setup.sh script for installing Vagrant dependencies and plugins via a provided curl command. [037ed691](https://github.com/electrocucaracha/openstack-multinode/commit/037ed691687d435ac105e6a50698dc8eaf0cd59d)

## [4.4.1] - 2019-09-20

### Changed

- Enabled Skydive by default in provisioning tasks and configuration, making its dashboard accessible at http://10.10.13.3:8085 for custom services listed in kolla-build.ini. [4a9fdcc7](https://github.com/electrocucaracha/openstack-multinode/commit/4a9fdcc78a393e9799816417554632eb3a2362e5)

## [4.4.0] - 2019-05-09

### Added

- Enabled hostname resolution for nodes in the cluster by modifying the /etc/hosts file to include the hostname, which may require manual review of affected systems after migration and introduces a new configuration step affecting the API contract. [7a3ed510](https://github.com/electrocucaracha/openstack-multinode/commit/7a3ed51027df3b712c44beadf28fa0ad3a9d5ae5)

## [4.3.3] - 2019-05-09

### Changed

- Updated configuration files and inventory settings to reflect the OpenStack Stein release requirements for a smooth upgrade process. [dfb2b8ba](https://github.com/electrocucaracha/openstack-multinode/commit/dfb2b8bacc47aeea148f5a0917882c070db89a31)

## [4.3.2] - 2019-05-09

### Changed

- Optimized Kolla images to support Stein release by updating Docker tags and adding Placement and OpenDaylight services to the default image list. [c463bc12](https://github.com/electrocucaracha/openstack-multinode/commit/c463bc121812b81439d6a26c8ade190f39263dd1)

## [4.3.1] - 2019-05-07

### Changed

- Optimized Docker image creation and configuration by switching to unprivileged permissions for registry provisioning. [40e86eae](https://github.com/electrocucaracha/openstack-multinode/commit/40e86eaef116e031f091385be46d01a34ab858ee)

## [4.3.0] - 2019-05-07

### Added

- Enabled package upgrades for virsh on Ubuntu 16.04 and 18.04 by adding the cloud-archive repository to setup.sh. [eff7a2ea](https://github.com/electrocucaracha/openstack-multinode/commit/eff7a2ea77885af854c23d9cee5fe383698c8a08)

## [4.2.9] - 2019-04-29

### Changed

- Updated source locations for over 50 OpenStack projects including Keystone, Nova, and Horizon to new version numbers, requiring no migration steps or breaking behavior. [f5941be6](https://github.com/electrocucaracha/openstack-multinode/commit/f5941be61526dddfa08403ddb9795b4ec103a505)

## [4.2.8] - 2019-04-26

### Changed

- Stabilized log storage for the registry server by updating its log directory to /var/log/kolla/, which requires users to migrate existing logs if necessary without altering any API or CLI contracts. [5dd81067](https://github.com/electrocucaracha/openstack-multinode/commit/5dd8106780c04c7db95933d3136f913a461b2ca3)

## [4.2.7] - 2019-04-26

### Changed

- Upgraded the registry to the stein release, which requires updating source locations in kolla-build.ini for components like neutron-lbaas and networking-ovn. [ecff3e15](https://github.com/electrocucaracha/openstack-multinode/commit/ecff3e159a4513ebd854ef14b1252a426f6835ec)

## [4.2.6] - 2019-04-26

### Changed

- Reduced the number of vCPUs allocated to the registry from 16 to 4 which may impact performance and require adjustments in resource allocation. [5898c6c7](https://github.com/electrocucaracha/openstack-multinode/commit/5898c6c70508d5d88577ece7e64cf6bcf86201a5)

## [4.2.5] - 2019-04-26

### Changed

- Simplified the Vagrant configuration to remove an unnecessary comment from the management network setting without changing its name or affecting API or CLI contracts. [14034fd2](https://github.com/electrocucaracha/openstack-multinode/commit/14034fd297d895ba44cee46075cefc70e1ad7c39)

## [4.2.4] - 2019-04-04

### Changed

- Optimized the registry.sh script to improve its maintainability and reliability on Debian-based systems without introducing breaking behavior or requiring migration steps, but note that it may behave differently on non-Debian platforms. [e8db2a4d](https://github.com/electrocucaracha/openstack-multinode/commit/e8db2a4d4a237b3136582ec4658c52f9e203352e)

## [4.2.3] - 2019-04-03

### Changed

- Optimized network configuration for libvirt external networks by requiring users to specify the network name when setting up private networks through the 'network' role. [4a0eaef8](https://github.com/electrocucaracha/openstack-multinode/commit/4a0eaef80f7636a9fc172a3db3f3382c9f959b84)

## [4.2.2] - 2019-04-03

### Changed

- Optimized ClearLinux support for users and maintainers by updating Travis CI configuration and Vagrantfile to leverage the -x flag for explicit exit codes and modifying the pdf.yml config schema with new network names. [68a51b7a](https://github.com/electrocucaracha/openstack-multinode/commit/68a51b7a1f759e82fee340586a43f86aca2dc2f9)

## [4.2.1] - 2019-03-18

### Changed

- Updated the `no_proxy` IP list to exclude custom tunnel and storage IPs specified in node configurations that utilize the "networks" configuration instead of "nics". [42b7e3ea](https://github.com/electrocucaracha/openstack-multinode/commit/42b7e3ea48f3ae194b2178c529fa0de2cee6fb0a)

## [4.2.0] - 2019-03-18

### Added

- Vagrant-libvirt now dynamically assigns hostnames to virtual machines by default without requiring manual intervention. [27d5e97c](https://github.com/electrocucaracha/openstack-multinode/commit/27d5e97c0ed83bb0632cafceea568bcbe860af6b)

## [4.1.12] - 2019-03-15

### Changed

- Network definitions are now centralized using the `networks` key in node configurations, eliminating redundant options and requiring users to update their node configurations accordingly. [1fdf245d](https://github.com/electrocucaracha/openstack-multinode/commit/1fdf245d1f8eb866a098ffda15b0b945f43b0c2d)

## [4.1.11] - 2019-03-13

### Changed

- Simplified inventory host file configuration by introducing new group definitions for baremetal children groups related to control, network, compute, storage, and monitoring hosts which are now inherited by services such as Sahara, Ceilometer, Congress, Panko, and Trove. [00f8d0eb](https://github.com/electrocucaracha/openstack-multinode/commit/00f8d0ebc8d83077facab2c2b577d7c60972f103)

## [4.1.10] - 2019-03-04

### Changed

- Enabled support for various Linux distributions including Ubuntu, CentOS, and OpenSUSE, allowing users to select their preferred distribution for deployment without modifying the Vagrantfile configurations. [1c924cfc](https://github.com/electrocucaracha/openstack-multinode/commit/1c924cfc015d134fc6932cb4508d498518f55b10)

## [4.1.9] - 2019-02-28

### Changed

- Enabled multi-provider support allowing users to specify provider in Vagrantfile instead of relying on environment variable. [ef740b52](https://github.com/electrocucaracha/openstack-multinode/commit/ef740b52788a410424737147de45b881bc589c14)

## [4.1.8] - 2019-02-28

### Changed

- The configuration and maintenance of bash scripts were optimized to comply with shellcheck recommendations by adding quotes around variable references and disabling certain checks where necessary without introducing any breaking behavior or API changes. [58a13a46](https://github.com/electrocucaracha/openstack-multinode/commit/58a13a46938dd7ac9500342791b5975c48b0ebc5)

## [4.1.7] - 2019-02-28

### Changed

- Updated setup.sh to ensure compatibility with newer versions of Vagrant and VirtualBox across various Linux distributions without requiring any changes from users. [af33a850](https://github.com/electrocucaracha/openstack-multinode/commit/af33a8508dea16d80bf32047fa831a6e3d6bcabf)

## [4.1.6] - 2019-01-30

### Changed

- Optimized openstack nodes provisioning scripts to improve functionality and resolve issues by enabling nested virtualization and mounting external partitions correctly. [c7ade72e](https://github.com/electrocucaracha/openstack-multinode/commit/c7ade72e13fe7ce6f2bfd249125f8f62e15b9651)

## [4.1.5] - 2019-01-04

### Changed

- Disabled image deployment by default to prevent images from being pushed after building, requiring no migration steps and updating the config schema accordingly. [90663afd](https://github.com/electrocucaracha/openstack-multinode/commit/90663afd13fafb965ea7af33271751cc46de9351)

## [4.1.4] - 2018-12-17

### Changed

- Enabled local registries to run more efficiently by preventing unnecessary restarts due to improved container startup checks that do not affect API contracts and require no migration steps. [dacc1360](https://github.com/electrocucaracha/openstack-multinode/commit/dacc13608544718b676d6cbf74631c423f744851)

## [4.1.3] - 2018-12-16

### Changed

- The setup script for Debian systems now properly cleans up configuration directories during setup to prevent potential conflicts and ensure smoother installation of Docker services on Debian-based systems. [d5ac0274](https://github.com/electrocucaracha/openstack-multinode/commit/d5ac0274c88e5d072f0d4bc37420ddca7c3aa87b)

## [4.1.2] - 2018-12-16

### Changed

- The default image list now includes kuryr and etcd services by default, affecting how images are built and deployed. [0caadaaf](https://github.com/electrocucaracha/openstack-multinode/commit/0caadaaf0e1224847647177f165e6749e06a2495)

## [4.1.1] - 2018-12-16

### Changed

- Improved handling of Linux distributions and user/group management to ensure seamless operation across various environments. [2f42349c](https://github.com/electrocucaracha/openstack-multinode/commit/2f42349c367bc6489eca05d66886374be9a02f6e)

## [4.1.0] - 2018-12-10

### Added

- Enabled support for building kolla images behind proxies or no-proxies by adding environment variable handling and extending the template with bifrost header and footer blocks. [6d6e8576](https://github.com/electrocucaracha/openstack-multinode/commit/6d6e8576b68c6e4aeb52e301fd18a4118f02eadc)

## [4.0.3] - 2018-10-16

### Changed

- Enabled users to perform additional tasks in kolla-ansible by expanding the undercloud.sh script to include pull and check actions without introducing any breaking behavior, requiring users to adapt their workflow accordingly. [ebbfd781](https://github.com/electrocucaracha/openstack-multinode/commit/ebbfd781e548c2fea5a4fed8ff726eacff75d6a4)

## [4.0.2] - 2018-10-16

### Changed

- Enabled users to access the opendaylight image during environment building by updating the default list of images in kolla-build.ini without introducing any breaking behavior or requiring migration steps. [c1c82044](https://github.com/electrocucaracha/openstack-multinode/commit/c1c820449e7e7d0998e0e7659d4647982ede42a0)

## [4.0.1] - 2018-10-15

### Changed

- Modernized configuration display for VM settings to a table-based layout that includes a total row for easy comparison of overall system resources. [905f61a5](https://github.com/electrocucaracha/openstack-multinode/commit/905f61a5f83d86dcefc95b0837863665de56a469)

## [4.0.0] - 2018-10-15

### Removed

- Simplified the Registry node provisioning process by eliminating the need for parallel execution order, allowing developers to follow standard setup procedures without any additional requirements. [41cb6c75](https://github.com/electrocucaracha/openstack-multinode/commit/41cb6c75ce52dbe988879691649f18c5fe77e7b0)

## [3.3.1] - 2018-10-15

### Changed

- Improved error handling and security measures were enabled for users running the setup script by correctly configuring proxy settings and NFS dependencies, opening necessary ports for NFS access when firewalld is enabled, and enforcing root privileges before execution. [3394db00](https://github.com/electrocucaracha/openstack-multinode/commit/3394db00867c439a52439db4a3daa5eb77f3af66)

## [3.3.0] - 2018-10-15

### Added

- Enabled improved performance for certain applications that utilize the vhost_net kernel module, requiring no migration steps and affecting users who rely on this feature for their workloads. [78b5b1f8](https://github.com/electrocucaracha/openstack-multinode/commit/78b5b1f894adc8884b87358838f2626aa8ad155b)

## [3.2.3] - 2018-10-15

### Changed

- Expanded controller host list in inventory/hosts.ini to include control01, control02, and control03, resolving an issue where kolla-ansible was selecting the wrong server for file copying and docker service startup. [98e5e427](https://github.com/electrocucaracha/openstack-multinode/commit/98e5e427b6ebeec894ba855152f43e7e6adf454c)

## [3.2.2] - 2018-10-15

### Changed

- Enabled openvswitch as the default image in kolla-build.ini configuration, requiring users to update their configurations and potentially adjust setup accordingly. [ca456526](https://github.com/electrocucaracha/openstack-multinode/commit/ca45652628244a071ff38984ce7bb9d9cd4bb232)

## [3.2.1] - 2018-10-09

### Changed

- The groupadd instruction now consistently creates the docker group across different environments by avoiding duplicate group creation errors and ensuring correct permissions setup during installation. [4180d988](https://github.com/electrocucaracha/openstack-multinode/commit/4180d9888d123f142acc3fcb7998c44084173ca4)

## [3.2.0] - 2018-10-08

### Added

- Nested virtualization is now enabled for Intel and AMD architectures allowing KVM to run nested VMs with improved performance. [9c0ae2df](https://github.com/electrocucaracha/openstack-multinode/commit/9c0ae2df459e2c44e704cdf89add7547fca2f72e)

## [3.1.3] - 2018-10-08

### Changed

- Simplified setup.sh installation to correctly install Vagrant and dependencies on various Linux distributions, requiring users who rely on vagrant-plugin installation and tox testing to manually update pip and install required packages. [124aa2f2](https://github.com/electrocucaracha/openstack-multinode/commit/124aa2f2b27be67555b41e058faa46ce9507e61b)

## [3.1.2] - 2018-09-09

### Changed

- Updated Vagrantfile and registry.sh scripts to utilize the Rocky stable release instead of master, introducing minimal breaking behavior for users relying on previous versions but preserving unchanged API contracts and security posture. [03c2d72c](https://github.com/electrocucaracha/openstack-multinode/commit/03c2d72cf032167ca747b4c8d963d1752b7c43fd)

## [3.1.1] - 2018-09-08

### Changed

- Modernized build status links in README.md to reference openstack-multinode instead of vagrant-kolla and added parallel node initialization instructions without altering API or CLI contracts, requiring users to re-run setup scripts due to the name change. [56617b45](https://github.com/electrocucaracha/openstack-multinode/commit/56617b45162fd7edeec8fe7a6d7c5bc642648deb)

## [3.1.0] - 2018-09-08

### Added

- Enabled users to better understand project setup through the addition of a diagram in the README.md file. [8b9d25ac](https://github.com/electrocucaracha/openstack-multinode/commit/8b9d25ac548c6aa341ead871406bb2811320b3df)

## [3.0.0] - 2018-09-08

### Removed

- Eliminated the test role from the configuration, which may necessitate users to review their configurations for compatibility with the updated setup. [733c96ae](https://github.com/electrocucaracha/openstack-multinode/commit/733c96aeba4e21214963719c056dc84143c8c0cd)

## [2.0.0] - 2018-09-02

### Removed

- Simplified the undercloud installation process by eliminating unnecessary setup instructions for proxy variables in the undercloud.sh script without introducing any breaking changes or modifying API contracts, CLI interfaces, security settings, or configuration schema definitions. [f56e5267](https://github.com/electrocucaracha/openstack-multinode/commit/f56e52676f2e7bcd808c8894c2030114897a6ae7)

## [1.2.3] - 2018-09-02

### Changed

- The vagrant user has been enabled to manage containers through membership in the docker group. [f27e1dbc](https://github.com/electrocucaracha/openstack-multinode/commit/f27e1dbc7b536a294b2f2d88c9172d4469e0a2f5)

## [1.2.2] - 2018-09-02

### Changed

- Hosts.ini nodes are now defined using range-based syntax for improved readability and consistency, replacing explicit node names without introducing breaking behavior or requiring migration steps. [1b190d32](https://github.com/electrocucaracha/openstack-multinode/commit/1b190d3240b4be0e9eccbafc95cb8f4fe7c90b7c)

## [1.2.1] - 2018-09-02

### Changed

- Reordered IP addresses in the config/pdf.yml file to optimize node configurations for compute01, network01, network02, storage01, and monitoring01 nodes. [35e2f551](https://github.com/electrocucaracha/openstack-multinode/commit/35e2f5510a80e3b6e2f08c3d3749d0a0ebb1241c)

## [1.2.0] - 2018-08-31

### Added

- Introduced softlinks for autocomplete functionality in registry.sh and undercloud.sh files, enabling users to autocomplete new commands directly in the terminal without breaking any API or CLI contract. [ba562964](https://github.com/electrocucaracha/openstack-multinode/commit/ba5629645f2ad05a3d0b4c330e7aa0e527f5acf8)

## [1.1.12] - 2018-08-31

### Changed

- Updated the kolla-build command to utilize configuration files with the .ini extension instead of .conf. [e1dcc0ed](https://github.com/electrocucaracha/openstack-multinode/commit/e1dcc0ed0d416364da0feefe25089e42f8d17760)

## [1.1.11] - 2018-08-31

### Changed

- Upgraded Vagrant version to 2.1.4, ensuring users can leverage the latest features and improvements without requiring any migration steps or changes to their existing setup. [246d04f6](https://github.com/electrocucaracha/openstack-multinode/commit/246d04f6900db4e279212f8bddf7a18b673f217d)

## [1.1.10] - 2018-08-31

### Changed

- The README file has been modernized to describe the deployment of OpenStack services through Kolla in a Multi-Node configuration. [db703262](https://github.com/electrocucaracha/openstack-multinode/commit/db703262e9f3c936882d802d8a1d43e1d53fb482)

## [1.1.9] - 2018-08-31

### Changed

- Configuration values now reflect changes in OpenStack release from queens to 7.0.0, including increased memory and CPU allocations for certain nodes, updates to network interfaces and external IP addresses, and the switch to using the kolla-ansible directory instead of etc/, with no breaking changes or migration requirements. [d3f7865d](https://github.com/electrocucaracha/openstack-multinode/commit/d3f7865dd46302d8111f082b4cbe7219a8fc302f)

## [1.1.8] - 2018-08-28

### Changed

- Updated Docker Registry Node configurations to point to the new registry address at 10.10.13.2:5000, requiring users who build images from the registry to update their configuration files accordingly. [23d37e11](https://github.com/electrocucaracha/openstack-multinode/commit/23d37e11137c593bbfec91a3d9354afd97ec82b6)

## [1.1.7] - 2018-08-20

### Changed

- Enabled streamlined deployment of various tasks including bootstrap, prechecks, deploy, and post-deploy through the inclusion of kolla-ansible actions in the deployment process with no migration required but noting that these actions are now executed using ansible instead. [2386e279](https://github.com/electrocucaracha/openstack-multinode/commit/2386e2799222204eeee39c8286f47e421e2097c7)

## [1.1.6] - 2018-08-20

### Changed

- Updated the network_interface value in the globals.yml configuration file from "eth0" to "eth1", requiring users who rely on this interface name to update their networking configurations accordingly. [6d398a1a](https://github.com/electrocucaracha/openstack-multinode/commit/6d398a1a329ce3aa2b75f1895cdcee0748116791)

## [1.1.5] - 2018-08-20

### Changed

- Corrected IP addresses in the inventory file to ensure accurate host connections for users relying on it for Ansible playbook execution. [1537bbe3](https://github.com/electrocucaracha/openstack-multinode/commit/1537bbe3960409091ce737a01f67fa037ca29399)

## [1.1.4] - 2018-08-17

### Changed

- Automated builds are now enabled on TravisCI's continuous integration platform, allowing users to monitor build status and receive notifications about failures through the web interface. [d961ffe5](https://github.com/electrocucaracha/openstack-multinode/commit/d961ffe54241db3f49a92efd069c2edcf9c243ff)

## [1.1.3] - 2018-08-17

### Changed

- Updated the management IP range to 192.168.121.0/27, affecting how nodes are configured and connected in the virtual network by changing the libvirt provider settings for the management network address. [444a181b](https://github.com/electrocucaracha/openstack-multinode/commit/444a181baeaa6d72f834eaaa61e57d460e743b52)

## [1.1.2] - 2018-08-17

### Changed

- Updated setup.sh to install Vagrant 2.1.2 by default and upgraded pip, adding support for proxy configurations and libvirt network settings. [43339046](https://github.com/electrocucaracha/openstack-multinode/commit/43339046ad18b9146b45703280b55652c539ca67)

## [1.1.1] - 2018-08-17

### Changed

- The provisioning method can now be customized through the setup.sh script's -p option, enabling users to tailor their OpenStack service deployments using the vagrant-kolla tool. [03d54787](https://github.com/electrocucaracha/openstack-multinode/commit/03d547878ae29512f944c73fe04b9e405c2343c8)

## [1.1.0] - 2018-07-04

### Added

- Introduced a setup script for installing dependencies that supports various Linux distributions and package managers, enabling users to easily install Vagrant required packages on their systems. [0d193868](https://github.com/electrocucaracha/openstack-multinode/commit/0d193868a6524d775c4892563dfc899d2b94d7e6)

## [1.0.1] - 2018-07-04

### Changed

- Optimized node configurations by enabling customizable settings within PDF files that guide Vagrant provisioning and configuration processes for cluster nodes. [88cee9ed](https://github.com/electrocucaracha/openstack-multinode/commit/88cee9edfe41c4dc895a9d599b51d7daba271f31)

## [1.0.0] - 2018-05-31

### Added

- Enabled support for OpenStack Kolla deployment projects by establishing project foundation including licensing terms under Apache-2.0 and setup instructions in README.md. [10a6e077](https://github.com/electrocucaracha/openstack-multinode/commit/10a6e077c2e0762fbae3f1a047c4e2640cc13380)
