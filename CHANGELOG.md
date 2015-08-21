Vagrant Development VM Changelog
================================

2.0.0 - UPCOMING
------------------
* Added prebuilt vagrant image from WebDevOps
* Modular provisioning in `vm.yml`
* Increased data disk size to 160 GB
* Improved provisioning feedback (splitted big ansible tasks into smaller ones)
* Improved general provisoning
* Switched to official docker installation command (removed docker ppa)
* Added distribution update switch in `vm.yml`
* Added auto installation custom kernel in `vm.yml`
* Added ext4, ext3, xfs and btrfs support for data image in `vm.yml`
* Added oh-my-zsh and prezto as zsh profiles
* Modular and more customizable `Vagrantfile`
* Automatic detection of CPUs and Memory (will use 1/4 of host) for MacOS and Linux
* Secured default vhost for reverse proxy (docker proxy)
* Auto rebuild VMware guest tools
* Secured SSL configuration (disabled RC4)
* Added basic and easy `customization/` folder (will deployed on server)
* Added firewall for bridged networks
* Many other smaller improvements and bugfixes

1.0.0 - 2015-06-17
------------------
* Initial Version
* Added Docker
* Added Docker reverse proxy (apache2)
* Added mail sandbox (postfix, dovecot)
* Added dnsmasq (with lookup of Docker containers)
* Added Samba
* Added ntp (chrony)
* Added [CliTools](https://github.com/mblaschke/clitools)
* Host support: Windows, Linux and MacOSX hosts
* Virtualization support: VMware, Parallels, VirtualBox
