===
SSH
===

=============== =======================
Setting         Value
=============== =======================
Server          IP or Hostname of VM (192.168.56.2)
Port            22
Username        vagrant
Password        vagrant
SSH Key         Automatically deployed from github, if account name is set (see vm.yml)
=============== =======================

.. code-block:: bash


   # connect via vagrant
   vagrant ssh

   # normal way
   ssh vagrant@192.168.56.2
