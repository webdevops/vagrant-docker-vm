ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

list:
	sh -c "echo; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile'| sort"

parallels-shrink:
	vagrant up
	vagrant ssh -- 'sudo touch /zero; sudo chmod 666 /zero; cat /dev/zero > /zero; sync; sleep 1; sudo rm /zero'
	vagrant ssh -- 'sudo touch /mnt/data/zero; sudo chmod 666 /mnt/data/zero; cat /dev/zero > /mnt/data/zero; sync; sleep 1; sudo rm /mnt/data/zero'
	vagrant halt
	prl_disk_tool compact --hdd disks/parallels-disk

vmware-shrink:
	vagrant up
	vagrant ssh -- 'sudo touch /zero; sudo chmod 666 /zero; cat /dev/zero > /zero; sync; sleep 1; sudo rm /zero'
	vagrant ssh -- 'sudo touch /mnt/data/zero; sudo chmod 666 /mnt/data/zero; cat /dev/zero > /mnt/data/zero; sync; sleep 1; sudo rm /mnt/data/zero'
	vagrant halt
	/Applications/VMware\ Fusion.app/Contents/Library/vmware-vdiskmanager -d disks/data
	/Applications/VMware\ Fusion.app/Contents/Library/vmware-vdiskmanager -k disks/data
