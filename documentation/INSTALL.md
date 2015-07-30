[<-- Back to main section](../README.md)

# Installation

## First startup

```bash
# Clone git repository
git clone --recursive --config core.autocrlf=false https://github.com/webdevops/vagrant-development.git devvm
cd devvm

# Customize the vm.yml with your favorite editor
vim vm.yml

# Setup Docker environment (only linux and mac, only once)
source provision/docker-init.sh

# Start vm
vagrant up

# Enter VM
vagrant ssh
```

Put this snipped in your .ssh/config:

    Host vm vagrant 192.168.56.2
        Hostname 192.168.56.2
        User     vagrant
        ForwardAgent  yes
        Compression   no
        StrictHostKeyChecking no
        UserKnownHostsFile=/dev/null

Now you can (if ssh key is loaded, otherwise use password 'vagrant' and ssh-copy-id)

    ssh vm

# Root privilege requirements for NFS

Under Linux and MacOS you will be asked for root rights (sudo).
If you don't want to enter your password every time [take a look at the vagrant manual for NFS usage](https://docs.vagrantup.com/v2/synced-folders/nfs.html)

## VM control

```bash
# Start VM
vagrant up

# Suspend VM
vagrant suspend

# Resume VM
vagrant resume

# Stop VM
vagrant halt

# Restart VM
vagrant restart

# Reload Vagrantfile changes (and restart VM)
vagrant reload

# Destroy the VM (and all data!)
vagrant destroy
```

## Vagrant Manager

If you want a GUI tool for managing Vagrant VMs you can use [Vagrant Manager](http://vagrantmanager.com/). With it you can controll your VMs from a system tray icon.
