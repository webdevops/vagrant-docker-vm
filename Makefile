ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent
.PHONY: list documentation

list:
	sh -c "echo; $(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep -v 'Makefile'| sort"

documentation:
	docker run -t -i --rm -p 8080:8000 -v "$$(pwd)/documentation/docs/:/opt/docs" -e "VIRTUAL_HOST=documentation.docker" -e "VIRTUAL_PORT=8000" webdevops/sphinx sphinx-autobuild --poll -H 0.0.0.0 /opt/docs html

parallels-shrink:
	vagrant up --provider="parallels"
	echo " * Cleanup docker images"
	vagrant ssh -- 'docker system prune -f &> /dev/null'
	echo " * Cleanup root partition"
	vagrant ssh -- 'sudo touch /zero; sudo chmod 666 /zero; cat /dev/zero > /zero 2> /dev/null; sync; sleep 1; sudo rm /zero'
	echo " * Cleanup data partition"
	vagrant ssh -- 'sudo touch /mnt/data/zero; sudo chmod 666 /mnt/data/zero; cat /dev/zero > /mnt/data/zero 2> /dev/null; sync; sleep 1; sudo rm /mnt/data/zero'
	vagrant halt
	echo " * Shrink discs"
	prl_disk_tool compact --buildmap --hdd disks/parallels-disk

vmware-shrink:
	vagrant up
	echo " * Cleanup docker images"
	vagrant ssh -- 'docker system prune -f &> /dev/null'
	echo " * Cleanup root partition"
	vagrant ssh -- 'sudo touch /zero; sudo chmod 666 /zero; cat /dev/zero > /zero 2> /dev/null; sync; sleep 1; sudo rm /zero'
	echo " * Cleanup data partition"
	vagrant ssh -- 'sudo touch /mnt/data/zero; sudo chmod 666 /mnt/data/zero; cat /dev/zero > /mnt/data/zero 2> /dev/null; sync; sleep 1; sudo rm /mnt/data/zero'
	vagrant halt
	echo " * Shrink discs"
	/Applications/VMware\ Fusion.app/Contents/Library/vmware-vdiskmanager -d disks/data
	/Applications/VMware\ Fusion.app/Contents/Library/vmware-vdiskmanager -k disks/data

vbox-shrink:
	vagrant up
	echo " * Cleanup docker images"
	vagrant ssh -- 'docker system prune -f &> /dev/null'
	echo " * Cleanup root partition"
	vagrant ssh -- 'sudo touch /zero; sudo chmod 666 /zero; cat /dev/zero > /zero 2> /dev/null; sync; sleep 1; sudo rm /zero'
	echo " * Cleanup data partition"
	vagrant ssh -- 'sudo touch /mnt/data/zero; sudo chmod 666 /mnt/data/zero; cat /dev/zero > /mnt/data/zero 2> /dev/null; sync; sleep 1; sudo rm /mnt/data/zero'
	vagrant halt
	echo " * Shrink discs"
	VBoxManage modifyhd --compact disks/vm-data.vdi


