# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = 2

########################
## Customization
########################

VAGRANT_CUSTOMIZATION = Proc.new {|config|
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
## YAML configuration loader
###############################################################################

require 'yaml'

path = "#{File.dirname(__FILE__)}"

# Get machine configuration
configuration = {}
if File.exist?(path + '/vm.yml')
	configuration = YAML::load(File.read(path + '/vm.yml')) || {}
end

## Defaults

if !configuration['VM'].has_key?('sharedFolder') or !configuration['VM']['sharedFolder']
    configuration['VM']['sharedFolder'] = {}
end

if !configuration['VM'].has_key?('portForwarding') or !configuration['VM']['portForwarding']
    configuration['VM']['portForwarding'] = {}
end

if !configuration['VM']['network'].has_key?('bridged') or !configuration['VM']['network']['bridged']
    configuration['VM']['network']['bridged'] = {}
end


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

if configuration['VM']['cpu'] =~ /auto/
  if OS.mac?
    configuration['VM']['cpu'] = `sysctl -n hw.ncpu`.to_i
  elsif OS.linux?
    configuration['VM']['cpu'] = `nproc`.to_i
  else
    configuration['VM']['cpu'] = 2
  end
end

if configuration['VM']['memory'] =~ /auto/
  if OS.mac?
    configuration['VM']['memory'] = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
  elsif OS.linux?
    configuration['VM']['memory'] = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
  else
    configuration['VM']['memory'] = 2048
  end

  # at least 1 GB
  if configuration['VM']['memory'].to_i < 1024
    configuration['VM']['memory'] = 1024
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
    config.vm.box = configuration['VM']['image']
    config.vm.box_check_update = true

    #################
    # Provider: Parallels
    #################

    # Parallels
    config.vm.provider :parallels do |v|
        v.name   = configuration['VM']['name']
        v.memory = configuration['VM']['memory']
        v.cpus   = configuration['VM']['cpu']
        v.update_guest_tools = true

        if configuration['VM']['gui']
            v.customize ["set", :id, "--startup-view", "window"]
            v.customize ["set", :id, "--on-window-close", "suspend"]
        else
            v.customize ["set", :id, "--startup-view", "headless"]
        end

        v.customize(
            "post-import", [
                "set", :id,
                 "--device-add", "hdd",
                 "--image", "#{VAGRANT_ROOT}/disks/parallels-disk",
                 "--type", "expand",
                 "--size", configuration['VM']['data']['size'] * 1024,
            ]
        )

        v.customize "pre-boot", [
          "set", :id,
          "--device-bootorder", "hdd0 hdd1"
        ]
    end

    #################
    # Provider: VMware
    #################

    # VMware Fusion and Workstation
    [:vmware_fusion, :vmware_workstation].each do |provider|
        config.vm.provider provider do |v|
            v.gui = configuration['VM']['gui']
            v.vmx["memsize"]  = configuration['VM']['memory']
            v.vmx["numvcpus"] = configuration['VM']['cpu']

            v.vmx['scsi0:1.filename'] = "#{VAGRANT_ROOT}/disks/data"
            v.vmx['scsi0:1.present']  = 'TRUE'
            v.vmx['scsi0:1.redo']     = ''
        end
    end

    #################
    # Provider: VirtualBox
    #################

    # VirtualBox
    config.vm.provider :virtualbox do |v|
        v.gui = configuration['VM']['gui']
        v.customize ["modifyvm", :id, "--name",                configuration['VM']['name']]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory",              configuration['VM']['memory']]
        v.customize ["modifyvm", :id, "--cpus",                configuration['VM']['cpu']]
        v.customize ["modifyvm", :id, "--chipset",             "ich9"]
        v.customize ["modifyvm", :id, "--ioapic",              "on"]
        v.customize ["modifyvm", :id, "--rtcuseutc",           "on"]
        v.customize ["modifyvm", :id, "--pae",                 "on"]
        v.customize ["modifyvm", :id, "--hwvirtex",            "on"]
        v.customize ["modifyvm", :id, "--nestedpaging",        "on"]

        v.customize ["modifyvm", :id, "--natdnsproxy1",        "on"]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

        # GFX settings
        v.customize ["modifyvm", :id, "--vram",               configuration['VM']['vram']]
        v.customize ["modifyvm", :id, "--graphicscontroller", "vboxvga"]
        v.customize ["modifyvm", :id, "--accelerate2dvideo",  "on"]
        v.customize ["modifyvm", :id, "--accelerate3d",       "on"]

        # second disk
        unless File.exist?(DiskVmData)
            v.customize ['createhd', '--filename', DiskVmData, '--size', configuration['VM']['data']['size'] * 1024]
            # v.customize ['modifyhd', DiskVmData, '--type', 'multiattach']
        end
        v.customize ['storageattach', :id, '--storagectl', configuration['VM']['virtualbox']['diskController'], '--port', 1, '--device', 0, '--type', 'hdd', '--medium', DiskVmData]

        # network
        v.customize ["modifyvm", :id, "--nictype1", "virtio"]
        v.customize ["modifyvm", :id, "--nictype2", "virtio"]
    end

    #################
    # Networking :: private
    #################
    config.vm.network "private_network",
        ip: configuration['VM']['network']['private']['address']


    #################
    # Networking :: public
    #################

    if configuration['VM']['network']['bridged'] && configuration['VM']['network']['bridged']['address'] != "false"
        if configuration['VM']['network']['bridged']['address'] == "auto"
            #################
            # auto bridged (dhcp)
            #################
            if configuration['VM']['network']['bridged']['bridge'] && configuration['VM']['network']['bridged']['bridge'] != ""
                config.vm.network "public_network",
                    bridge: configuration['VM']['network']['bridged']['bridge']
            else
                config.vm.network "public_network"
            end
        elsif configuration['VM']['network']['bridged']['address'] && configuration['VM']['network']['bridged']['address'] != ""
            #################
            # auto bridged (dhcp)
            #################
            config.vm.network "public_network",
                ip: "#{configuration['VM']['network']['bridged']['address']}",
                bridge: configuration['VM']['network']['bridged']['bridge']
      end
    end

    #################
    # Port forwarding
    #################

    configuration['VM']['portForwarding'].each do |port|
        if !port.has_key?('guestIP')
            port['guestIp'] = ''
        end

        if !port.has_key?('hostIp')
            port['guestIp'] = ''
        end

        if !port.has_key?('protocol')
            port['protocol'] = 'tcp'
        end

        config.vm.network :forwarded_port,
            guest: "#{port['guest']}",
            guest_ip: "#{port['guestIP']}",
            host: "#{port['host']}",
            host_ip: "#{port['hostIp']}",
            protocol: "#{port['protocol']}"
    end

    #################
    # Shared folders
    #################

    # Ensure proper permissions for nfs mounts
    config.nfs.map_uid = Process.uid
    config.nfs.map_gid = Process.gid

    configuration['VM']['sharedFolder'].each do |mount|
        if !mount.has_key?('type')
            mount['type'] = 'vm'
        end

        if mount['type'] =~ /home/
            #################
            # Home (only unix)
            #################
            if OS.unix?
                config.vm.synced_folder "#{ENV['HOME']}",
                    "#{ENV['HOME']}",
                    :nfs => { :mount_options => [ "dmode=775", "fmode=774" ] }
            end

        elsif mount['type'] =~ /nfs/
            #################
            # NFS
            #################
            config.vm.synced_folder "#{mount['src']}",
                "#{mount['target']}",
                :nfs => { :mount_options => [ "dmode=775", "fmode=774" ] }

        elsif mount['type'] =~ /smb/
            #################
            # CIFS/SMB
            #################
            config.vm.synced_folder "#{mount['src']}",
                "#{mount['target']}",
                type: "smb"

        else
            #################
            # VM (built-in)
            #################
            config.vm.synced_folder "#{mount['src']}",
                "#{mount['target']}"
        end
    end

    #################
    # Workarounds
    #################
    #config.ssh.host = configuration['VM']['network']['private']['address']
    if configuration['VM']['workaround']['useSshPasswordAuth']
        # Fallback ssh connection (https://github.com/mitchellh/vagrant/issues/5186)
        # -> Authentication issues? Workaround:
        config.ssh.username = 'vagrant'
        config.ssh.password = 'vagrant'
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
