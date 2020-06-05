# Vagrant Docker Development-VM

[![latest ubuntu-16.04](https://img.shields.io/badge/latest-ubuntu_16.04-green.svg?style=flat)](https://github.com/webdevops/vagrant-docker-vm/tree/ubuntu-16.04)
[![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](/LICENSE)

![Vagrant Development VM login](/documentation/VagrantVM.png)


> # *Important Note:* This project isn't actively maintained anymore. You can use `codekitchen/dinghy` as a kind of drop-in-replacement if You don't want to use tools like Docker Desktop for Mac and DDEV nowadays!

Support for:

- VirtualBox
- VMware (preferred)
- Parallels (preferred)

## What is Vagrant?

Vagrant is a tool for automatic creation, configuration, management and provisioning of VMs inside VirtualBox, VMware and Parallels (and others).
It will create and manage all VM network interfaces, shares and settings  (eg. number of cpus, memory...).

Hint: Vagrant doesn't provides GUI tools, it's just a CLI tool.

## Features

- Ubuntu 16.04 LTS
- Docker daemon
- HTTP Reverse Proxy (dinghy reverse proxy)
- Consul with registrator
- Mail sandbox (catches all local and outgoing SMTP connections, with IMAP service)
- Samba shares (eg. for Windows)
- Local development environment

## Documentation

- [Vagrant Docker VM Documentation](http://webdevops-documentation.readthedocs.io/projects/vagrant-docker-vm/en/ubuntu-16.04/).

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
