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
VAGRANT_VM_GUI = true

# Name of VM instance
VAGRANT_VM_NAME          = 'DEV-VM'

# System settings
VAGRANT_VM_CPUS          = 4
VAGRANT_VM_CPU_EXEC_CAP  = 100
VAGRANT_VM_MEMORY        = 1512
VAGRANT_VM_DATA_SIZE     = 160
VAGRANT_VM_IP_INTERNAL   = '192.168.56.2'

# Port forwarding
VAGRANT_VM_FORWARD_IP    = '127.0.0.1'

###################
# Vagrant image
###################

## Prebuilt image
VAGRANT_IMAGE = 'webdevops/ubuntu-docker'

## BoxCutter plain Ubuntu image
#VAGRANT_IMAGE = 'box-cutter/ubuntu1404-docker'

########################
## VirtualBox
########################

# Disk image controller, change change between images, eg.
#  -> 'IDE Controller'
#  -> 'SATA Controller'
VIRTUALBOX_DISK_CONTROLLER = 'IDE Controller'


########################
## Customization
########################

VAGRANT_CUSTOMIZATION = Proc.new {|config|

    ## Networks

    # Public network (big security issue, don't enable!)
    # config.vm.network "public_network"

    ## Port forwardings

    # Public HTTP server
    # config.vm.network "forwarded_port", guest: 80, host: 80, auto_correct: true
    # config.vm.network "forwarded_port", guest: 443, host: 443, auto_correct: true

    # MySQL (local only)
    # config.vm.network "forwarded_port", guest: 13306, host: 3306, host_ip: '127.0.0.1', auto_correct: true

    # Docker port (local only)
    # config.vm.network "forwarded_port", guest: 2375, host: 2375, host_ip: '127.0.0.1', auto_correct: true

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
        v.customize ["modifyvm", :id, "--memory",              VAGRANT_VM_MEMORY]
        v.customize ["modifyvm", :id, "--cpus",                VAGRANT_VM_CPUS]
        v.customize ["modifyvm", :id, "--cpuexecutioncap",     VAGRANT_VM_CPU_EXEC_CAP]
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
    ["vmware_fusion", "vmware_workstation"].each do |provider|
        config.vm.provider provider do |v, override|
            v.gui = VAGRANT_VM_GUI
            v.vmx["memsize"]  = VAGRANT_VM_MEMORY
            v.vmx["numvcpus"] = VAGRANT_VM_CPUS

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
        v.memory = VAGRANT_VM_MEMORY
        v.cpus   = VAGRANT_VM_CPUS
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
    elsif OS.mac?
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
