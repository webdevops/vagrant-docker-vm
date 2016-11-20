================
Samba (SMB/CIFS)
================

=============== =======================
Setting         Value
=============== =======================
Server          IP or Hostname of VM (192.168.56.2)
Username        vagrant
Password        vagrant

Share /vagrant  /home/vagrant
Share /projects /mnt/data/projects/
Share /tmp      /tmp

Explorer URL    \\\\192.168.56.2\code
=============== =======================

MacOS and Linux don't need Samba, Vagrant will use shared folders.

For MacOS the /Users directory will be mounted under /Users in Vagrant VM to enable
transparent external docker access.
