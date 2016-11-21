============
File Sharing
============

Sharing types
-------------

============ ======== ============ =========================
Share type   Windows  Linux/macOS  Notes
============ ======== ============ =========================
NFS          *no*     **yes**      Fastest and reliable
CIFS         **yes**  **yes**      Fast and reliable
SMB          **yes**  **yes**      old Protocol, use CIFS
**none**     **yes**  **yes**      Slow on VirtualBox
============ ======== ============ =========================

Linux/MacOS
-----------

By default your home directory is mounted into the VM so files from outside are available inside the Vagrant Docker VM.
You can customize mounting inside the ``vm.yml``.

For sharing NFS is used and is a stable and fast solution for sharing data between the VM and your host system.
When encounting slowdown in VirtualBox you should try to switch to VMware or Parallels.

Windows
-------

On windows no directory is shared by default and sharing needs to be defined in ``vm.yml``.

As alternative there is a ``/home/vagrant/projects`` directory which can be access by using SMB/CIFS (windows shares)
from your explorer: ``\\192.168.56.2``

