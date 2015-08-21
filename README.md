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

## Why Vagrant and not Boot2Docker?

I wanted a customizable development box (with possiblity to use it as sandbox) and i also wanted my favorite
development tools inside my box which are up2date.

Also [Vagrant provides a sharing/connection service](http://docs.vagrantup.com/v2/share/) that will make
your Vagrant box public accessible (eg if you want to show a customer the current result of your work).

Only services (apache, nginx, mysql and other) are used inside docker containers.
Working files are stored inside the vm-box (the old way) or outside (the modern way) with shares.

Also this VM should be a sandbox so eg. no email should be send to other servers - they are catched by a
local postfix daemon and can be accessed by IMAP (dovecot).

Following the "keep it simple, stupid" this box provides all tools with a simple "vagrant up"

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

Thanks for support, ideas and issues ...
- [Ingo Pfennigstorf](https://github.com/ipf)
- [Florian Tatzel](https://github.com/PanadeEdu)
- [Achim Fritz](https://twitter.com/achimfritz73)
- [Rainer Zeh](https://twitter.com/rzeh)
- [Philipp Kitzberger](https://github.com/Kitzberger)

Did I forget anyone? Send me a tweet or create pull request!

## TODO
- Reverse Proxy
  - distributed perverse proxy configuration via shared folders for easy and fast deployment
- auto update composer and stuff? -> ansible tag?
- Vagrantfile
  - private IP-address
  - VAGRANT_VM_DATA_SIZE vmware
  - https://github.com/BerlinVagrant/vagrant-dns
- move vagrant home to shared folder?
- /etc/host provision
- testing
