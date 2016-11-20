===============
Getting Started
===============

------------
Requirements
------------

- Vagrant_
- VagrantManager_ (optional)
- Virtualization Software (VirtualBox, VMware or Parallels)


------------
Installation
------------

Install Vagrant
---------------
Download Vagrant_ install it.

When using VMware you also need the Vagrant VMware plugin (license needed!), for Parallels the Vagrant Parallels plugin is needed.

===================================== ========================================================== ==============================================
Virtualization Software               Command                                                    Notes
===================================== ========================================================== ==============================================
VirtualBox (all)                      *included*                                                 Slow to medium performance
VMware Workstation (Linux/Windows)    ``vagrant plugin install vagrant-vmware-workstation``      License for VMware and plugin needed
VMware Fusion (MacOS)                 ``vagrant plugin install vagrant-vmware-fusion``           License for VMware and plugin needed
Parallels Desktop (MacOS)             ``vagrant plugin install vagrant-parallels``               License for Parallels Desktop needed
===================================== ========================================================== ==============================================


Clone and create Vagrant Docker VM
----------------------------------

Just clone the Vagrant Docker VM (or download as zip), customize the `vm.yml` and create the VM by using Vagrant:

.. code-block:: bash

   # Clone git repository
   git clone --recursive --config core.autocrlf=false https://github.com/webdevops/vagrant-development.git devvm
   cd devvm

   # Customize the vm.yml with your favorite editor
   vim vm.yml

   # Customize the Vagrantfile with your favorite editor
   vim Vagrantfile

   # Setup Docker environment (only linux and mac, only once)
   source provision/docker-init.sh

   # Start vm
   vagrant up

   # Enter VM
   vagrant ssh

**Setup .ssh/config:**

.. code-block:: config

    Host vm vagrant 192.168.56.2
        Hostname 192.168.56.2
        User     vagrant
        ForwardAgent  yes
        Compression   no
        StrictHostKeyChecking no
        UserKnownHostsFile=/dev/null

-> now you can jump direclty into the VM with ``ssh vm``

Under Linux and MacOS you will be asked for root rights (sudo).
If you don't want to enter your password every time take a look at the vagrant manual for NFS usage: https://docs.vagrantup.com/v2/synced-folders/nfs.html

------------------
Vagrant cheatsheet
------------------

===================================== =========================================================================================================
Command                               Description
===================================== =========================================================================================================
``vagrant up``                        Create VM or startup previous created VM
``vagrant halt``                      Shutdown VM
``vagrant reload``                    Restart VM
``vagrant destroy``                   Kill and destroy the VM
``vagrant suspend``                   Suspend VM
``vagrant resume``                    Resume suspended VM
===================================== =========================================================================================================

If you want a GUI tool for managing Vagrant VMs you can use VagrantManager_. With it you can controll your VMs from a system tray icon.


.. _Vagrant: https://www.vagrantup.com
.. _VagrantManager: http://vagrantmanager.com/
