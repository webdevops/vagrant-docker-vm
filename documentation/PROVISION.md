[<-- Back to main section](../README.md)

# Provision (Ansible)

## Introduction

The installation and maintanance of services, tools and files are done with the provisioning tool Ansible.
It will check and correct most of the issues automatically.

## Packages

- Repositories
  - Default ubuntu + extras + backports
  - Percona DB
- Packages
  - docker utilts (docker-compose)
  - zsh (default shell, grml config)
  - development tools (colordiff, jq, ack-grep, sloccount)
  - vcs tools (git, git flow, svn, tig)
  - filesystem tools (fuse with sshfs)
  - server tools (ldaputils, swaks)
  - compiler suite (gcc, sass)
  - packaging tools (unrar, unace, 7zip, bzip2)
  - npm (with grunt, gulp and other tools)
  - phars (composer, pack, phpunit)
  - general tools (moreutils, incron, byobu, tmux, netcat, cstream)
  - analysis tools (htop, atop, iftop, mytop, iotop, pfqueue)
  - editors (nano, vim)
  - debugging tools (strace)
  - [CliTools (as "ct")](https://github.com/mblaschke/vagrant-clitools)
- Daemons
  - dnsmasq
  - samba
  - zram
  - haveged
  - postfix and dovecot (user: vagrant, password: vagrant, [more informations in README-SERVICES.md](README-SERVICES.md).)
