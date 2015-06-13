[<-- Back to main section](../README.md)

# Usage

## Access to VM

You can get access to this VM with [SSH (ssh, rsync, scp) or with SMB (Samba)](SERVICES.md).

## Projects storage

This VM has two disks, the main OS disk and a bigger storage disk.
The `/home/vagrant/projects/` directory is stored on the bigger storage disk. Here you should put your project files
if you don't want to use the automatic NFS mounts (eg. for Windows users).

You can get access to `/home/vagrant/projects/` though the Samba share `projects`.


## Mounts

The directory of the Vagrantfile is mounted under /vagrant (vagrant default).

Under Linux and MacOS your home directory is mounted under the same path as your host system.
eg.

Host System: /Users/foo/
VM: /Users/foo/

Hint: This handling is needed if you want to use docker-compose from your host system.

# Windows specific

If you're working under Windows you can put your files under `/home/vagrant/projects/`

You can access these Files via Samba.

1. Map a new Network Drive
2. Select Drive Letter
3. Enter: \\192.168.56.2
4. Browse and select the directory **projects**

Use the following Credentials:

Username: \vagrant
Password: vagrant
