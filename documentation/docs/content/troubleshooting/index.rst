===============
Troubleshooting
===============

Startup or update errors
------------------------

Reprovision the VM
~~~~~~~~~~~~~~~~~~

You can safely reprovision your VM without losing data:

.. code-block:: bash

   # if box is NOT started
   vagrant up --provision

   # if box is already started
   vagrant provision


Windows 10 (Tech Preview) and VMWare
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It can happen that the **Virtual Network Adapters** (in this case host only adapter)
break **on every shutdown** or **disconnect** from Network.

Windows 10 has **currently issues with Virtual Networks** on different VM Softwares.
With VMWare a Workaround can be resetting the Network Adapters right before
starting the VM.

1. Shut Down the VM (if not down already)
2. Open VMWare
3. Open in Menu: **Edit > Virtual Network Editor...**
4. Request Admin Rights in this window (if not already started with them)
5. Click: **Restore Defaults**

This will reset all virtual Network Adapters.
If you now start Vagrant with **vagrant up**, the required Adapters will be
recreated.


General errors
--------------

Disk usage is high or disk is full
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can safely run ``docker-clean`` to remove old and unused images.

Networking issues
-----------------

No IP address or no network
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Remove the udev rule for network interfaces:

`sudo rm /etc/udev/rules.d/70-persistent-net.rules`

Docker errors
-------------

Error response from daemon: client and server don't have same version (client : 1.19, server: 1.18)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Your docker client has been updated, just rerun provisioning to update the Docker server.

