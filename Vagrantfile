# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = 2

###############################################################################
## Configuration
###############################################################################

########################
## General
########################

# Show vm gui (terminal window, virtualbox, vmware)
VAGRANT_VM_GUI = false

# Name of VM instance
VAGRANT_VM_NAME = 'DEV-VM'

# CPU count (auto = all available cores, 2 = only 2 cores)
VAGRANT_VM_CPUS   = 'auto'

# Memory usage (auto = 1/4 system memory, 1500 = 1.5 GB)
VAGRANT_VM_MEMORY = 'auto'

# Disk size of data image (GB)
VAGRANT_VM_DATA_SIZE = 160

# Host-only IP address (for communication between host and vm)
VAGRANT_VM_IP_INTERNAL = '192.168.56.2'

###################
# Vagrant image
###################

# You can use nearly any Ubuntu 14.04 vagrant base image.
# This VM is tested with box-cutter and webdevops image.
#
# box-cutter is a plain Ubuntu image and webdevops image is a
# prebuilt one with all tools preinstalled (faster provisioning)
#
# Images:
# -> webdevops/ubuntu-docker
# -> box-cutter/ubuntu1404-docker
#

VAGRANT_IMAGE = 'webdevops/ubuntu-docker'

########################
## VirtualBox
########################

# Disk image controller, change change between images, eg.
# You sometimes have to switch controller if the image is using another one.
# See VM settings in VirtualBox for the correct naming.
#
#  -> 'IDE Controller'
#  -> 'SATA Controller'

VIRTUALBOX_DISK_CONTROLLER = 'IDE Controller'


########################
## Customization
########################

VAGRANT_CUSTOMIZATION = Proc.new {|config|

    # Fallback ssh connection (https://github.com/mitchellh/vagrant/issues/5186)
    # -> Authentication issues? Workaround:
    # config.ssh.username = 'vagrant'
    # config.ssh.password = 'vagrant'

    ## Port forwardings

    # Public HTTP server
    # config.vm.network "forwarded_port", guest: 80, host: 80, auto_correct: true
    # config.vm.network "forwarded_port", guest: 443, host: 443, auto_correct: true

    # MySQL (local only)
    # config.vm.network "forwarded_port", guest: 13306, host: 3306, host_ip: '127.0.0.1', auto_correct: true

    # Docker port (local only)
    # config.vm.network "forwarded_port", guest: 2375, host: 2375, host_ip: '127.0.0.1', auto_correct: true

    ## Networks

    # Public network
    #  |WARNING| This can be a big security issue and an attacker could
    #  |WARNING| gain access also to host (because of shares or services)!
    #  |WARNING| Only use if you're sure about the risks!
    #  |WARNING| If you need access to services use the port forwarding features!
    # config.vm.network "public_network"

}

###############################################################################
## --- Do not edit below ---
###############################################################################


###############################################################################
## --- OS detection ---
###############################################################################

module OS
    def OS.windows?
        (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end

    def OS.mac?
        (/darwin/ =~ RUBY_PLATFORM) != nil
    end

    def OS.unix?
        !OS.windows?
    end

    def OS.linux?
        OS.unix? and not OS.mac?
    end
end

###############################################################################
## --- Ressource detection ---
###############################################################################

if VAGRANT_VM_CPUS =~ /auto/
  if OS.mac?
    _VAGRANT_VM_CPUS = `sysctl -n hw.ncpu`.to_i
  elsif OS.linux?
    _VAGRANT_VM_CPUS = `nproc`.to_i
  else
    _VAGRANT_VM_CPUS = 2
  end
else
    _VAGRANT_VM_CPUS = VAGRANT_VM_CPUS
end

if VAGRANT_VM_MEMORY =~ /auto/
  if OS.mac?
    _VAGRANT_VM_MEMORY = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
  elsif OS.linux?
    _VAGRANT_VM_MEMORY = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
  else
    _VAGRANT_VM_MEMORY = 2048
  end
else
    _VAGRANT_VM_MEMORY = VAGRANT_VM_MEMORY
end

###############################################################################
## --- Disc setup ---
###############################################################################

require 'shellwords'
VAGRANT_ROOT = File.dirname(File.expand_path(__FILE__))
DiskVmData = File.join(VAGRANT_ROOT, '/disks/vm-data.vdi')

###############################################################################
## --- Vagrant setup ---
###############################################################################

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = VAGRANT_IMAGE
    config.vm.box_check_update = true

    #################
    # Provider: VirtualBox
    #################

    # VirtualBox
    config.vm.provider :virtualbox do |v|
        v.gui = VAGRANT_VM_GUI
        v.customize ["modifyvm", :id, "--name",                VAGRANT_VM_NAME]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory",              _VAGRANT_VM_MEMORY]
        v.customize ["modifyvm", :id, "--cpus",                _VAGRANT_VM_CPUS]
        v.customize ["modifyvm", :id, "--chipset",             "ich9"]
        v.customize ["modifyvm", :id, "--ioapic",              "on"]
        v.customize ["modifyvm", :id, "--rtcuseutc",           "on"]
        v.customize ["modifyvm", :id, "--pae",                 "on"]
        v.customize ["modifyvm", :id, "--hwvirtex",            "on"]
        v.customize ["modifyvm", :id, "--nestedpaging",        "on"]

        # Workaround: stability fix
        v.auto_nat_dns_proxy = false
        v.customize ["modifyvm", :id, "--natdnsproxy1", "off" ]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "off" ]

        # second disk
        unless File.exist?(DiskVmData)
            v.customize ['createhd', '--filename', DiskVmData, '--size', VAGRANT_VM_DATA_SIZE * 1024]
            # v.customize ['modifyhd', DiskVmData, '--type', 'multiattach']
        end
        v.customize ['storageattach', :id, '--storagectl', VIRTUALBOX_DISK_CONTROLLER, '--port', 1, '--device', 0, '--type', 'hdd', '--medium', DiskVmData]

        # network
        v.customize ["modifyvm", :id, "--nictype1", "virtio"]
        v.customize ["modifyvm", :id, "--nictype2", "virtio"]
    end

    #################
    # Provider: VMware
    #################

    # VMware Fusion and Workstation
    [:vmware_fusion, :vmware_workstation].each do |provider|
        config.vm.provider provider do |v|
            v.gui = VAGRANT_VM_GUI
            v.vmx["memsize"]  = _VAGRANT_VM_MEMORY
            v.vmx["numvcpus"] = _VAGRANT_VM_CPUS

            v.vmx['scsi0:1.filename'] = "#{VAGRANT_ROOT}/disks/data"
            v.vmx['scsi0:1.present']  = 'TRUE'
            v.vmx['scsi0:1.redo']     = ''
        end
    end

    #################
    # Provider: Parallels
    #################

    # Parallels
    config.vm.provider :parallels do |v|
        v.name   = VAGRANT_VM_NAME
        v.memory = _VAGRANT_VM_MEMORY
        v.cpus   = _VAGRANT_VM_CPUS
        v.optimize_power_consumption = false
        v.update_guest_tools = true

        v.customize(
            "post-import", [
                "set", :id,
                 "--device-add", "hdd",
                 "--image", "#{VAGRANT_ROOT}/disks/parallels-disk",
                 "--type", "expand",
                 "--size", VAGRANT_VM_DATA_SIZE * 1024,
            ]
        )

        v.customize "pre-boot", [
          "set", :id,
          "--device-bootorder", "hdd0 hdd1"
        ]
    end

    #################
    # Networking
    #################
    config.vm.network "private_network", ip: VAGRANT_VM_IP_INTERNAL

    #################
    # Port forwarding
    #################

    # nothing defined

    #################
    # Shared folders
    #################

    if OS.windows?
        ## Windows
        # configure shared folders here
    elsif OS.unix?
        ## Linux/Unix/MacOS
        config.vm.synced_folder "#{ENV['HOME']}", "#{ENV['HOME']}", :nfs => { :mount_options => [ "dmode=775", "fmode=774" ] }
    end

    #################
    # Provisioning
    #################

    # Workaround: shell is not a tty
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    # Bootstrap (only first time)
    config.vm.provision "bootstrap", type: "shell" do |s|
        s.inline = "sudo bash /vagrant/provision/bootstrap.sh"
    end

    # Maintenance (run always)
    config.vm.provision "maintenance", run: "always", type: "shell" do |s|
        s.inline = "sudo bash /vagrant/provision/maintenance.sh"
    end

    #################
    # Customization
    #################

    VAGRANT_CUSTOMIZATION.call(config)

end
