======
Docker
======

Docker is running on default port ``2376`` and is accessable from outside without SSL/TLS.

Storage is configured to use AUFS but also possible to use BTRFS (see ``vm.yml``)

Environment variables
---------------------

.. code-block:: bash

   export DOCKER_HOST=tcp://192.168.56.2:2375
   export DOCKER_TLS_VERIFY=

