============
Provisioning
============

The main provisioning of the VM directly after creation is done by Ansible. With Ansible complex tasks are configured
in simple yml files so the provisioing is not too complex even for new users.

============================== =========================================================================================
Script                         Description
============================== =========================================================================================
provision/bootstrap.sh         Run for new VMs or when `vagrant provision` or `vagrant up --provison` is called
provision/maintenance.sh       Run every time the VM is started (startup tasks)
============================== =========================================================================================
