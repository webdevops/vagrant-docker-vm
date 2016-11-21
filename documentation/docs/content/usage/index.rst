=====
Usage
=====

Customization
-------------

Put your custom files for your home directory `/home/vagrant` into  `./home`.
Files for `/etc` customization must be in `customization/etc`.

After provisioning all files will be synchronized to their destination folders.

Access to VM
------------

You can get access to this VM with SSH or SMB/CIFS, see SERVICE section for more details.

Projects storage
----------------

This VM has two disks, the main OS disk and a bigger storage disk.
The ``/home/vagrant/projects/`` directory is stored on the bigger storage disk. Here you should put your project files
if you don't want to use the automatic NFS mounts (eg. for Windows users).

You can get access to ``/home/vagrant/projects/`` though the Samba share ``projects``.


Mounts
------

The directory of the Vagrantfile is mounted under /vagrant (vagrant default).

Under Linux and MacOS your home directory is mounted under the same path as your host system.
eg.

Host System: /Users/foo/
VM: /Users/foo/

Hint: This handling is needed if you want to use docker-compose from your host system.

Windows specific
~~~~~~~~~~~~~~~~

If you're working under Windows you can put your files under ``/home/vagrant/projects/``

You can access these Files via Samba.

#. Map a new Network Drive
#. Select Drive Letter
#. Enter: \\\\192.168.56.2 (Username: ``vagrant`` / Password: ``vagrant``)
#. Browse and select the directory **projects**


Destroy & Recreate
------------------

VirtualBox
~~~~~~~~~~

With ``vagrant destroy`` you will destroy the VM and also the data disk so you can immediately
recreate the box with ``vagrant up``.

VMware & Parallels
~~~~~~~~~~~~~~~~~~

If you're using VMware or Parallels your disk will be stored inside the ``disk/`` directory.

After ``vagrant destroy`` you need to destroy these disk if you want a clean reinstallation:

VMware: Change to ``disks/`` directory and reset the VMware disk data files with git: ``git checkout data*``

Parallels: Just remove the directory ``disks/parallels-disk/``.

