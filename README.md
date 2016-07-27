# Vagrant Docker Development-VM

[![latest v1.0.0](https://img.shields.io/badge/latest-v1.0.0-green.svg?style=flat)](https://github.com/mblaschke/vagrant-development/releases/tag/1.0.0)
[![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](/LICENSE)

![Vagrant Development VM login](/documentation/VagrantVM.png)

Support for:

- VitualBox
- VMware (preferred)
- Parallels (preferred)

## What is Vagrant?

Vagrant is a tool for automatic creation, configuration, management and provisioning of VMs inside VirtualBox, VMware and Parallels (and others).
It will create and manage all VM network interfaces, shares and settings  (eg. number of cpus, memory...).

Hint: Vagrant doesn't provides GUI tools, it's just a CLI tool.

## Features

- Ubuntu 16.04 LTS
- Docker daemon
- HTTP Reverse Proxy
- Mail sandbox (catches all local and outgoing SMTP connections, with IMAP service)
- Samba shares (eg. for Windows)
- Local development environment

## Table of contents

- [Requirements](/documentation/REQUIREMENTS.md)
- [Installation](/documentation/INSTALL.md)
- [Usage](/documentation/USAGE.md)
- [Customization](/documentation/CUSTOMIZATION.md)
- [Updating - Keep your box up2date](/documentation/UPDATE.md)
- [Services (mail, samba, ssh... ports, credentials)](/documentation/SERVICES.md)
- [Using Docker](/documentation/DOCKER.md)
- [Using CliTools](/documentation/CLITOOLS.md)
- [About Provisioning](/documentation/PROVISION.md)
- [Troubleshooting](/documentation/TROUBLESHOOTING.md)
- [Changelog](/CHANGELOG.md)

## Credits

Thanks for your support, ideas and issues
- [Ingo Pfennigstorf](https://github.com/ipf)
- [Florian Tatzel](https://github.com/PanadeEdu)
- [Achim Fritz](https://twitter.com/achimfritz73)
- [Rainer Zeh](https://twitter.com/rzeh)
- [Philipp Kitzberger](https://github.com/Kitzberger)
- [Josef Glatz](https://github.com/jousch)
- [Elmar Hinz](https://github.com/elmar-hinz)
- [Alexander Grein](https://github.com/rabe69)

Did I forget anyone? Send me a tweet or create pull request!
