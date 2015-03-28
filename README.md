# Vagrant Docker Development-VM

Support for:

- VitualBox
- VMware (preferred)

## Why Vagrant and not Boot2Docker?

I wanted a customizable development box (with possiblity to use it as sandbox) and i also wanted my favorite
development tools inside my box which are up2date.

Only services (apache, nginx, mysql and other) are used inside docker containers.
Working files are stored inside the vm-box (the old way) or outside (the modern way) with shares.

Also this VM should be a sandbox so eg. no email should be send to other servers - they are cached by a
local postfix daemon and can be accessed by IMAP (dovecot).

Following the "keep it stupid simple" this box provides all tools with a simple "vagrant up"

## Installation

### First startup

```bash
# Clone git repository
git clone https://github.com/mblaschke/vagrant devvm
cd devvm

# Customize the vm.yml with your favorite editor
vim vm.yml

# Setup Docker environment (only linux and mac, only once)
source ~/provision/docker-init.sh

# Start vm
vagrant up

# Enter VM
vagrant ssh
```

### VM control

```bash
# Start VM
vagrant up

# Suspend VM
vagrant suspend

# Resume VM
vagrant resume

# Stop VM
vagrant halt

# Restart VM
vagrant restart

# Reload Vagrantfile changes (and restart VM)
vagrant reload

# Destroy the VM (and all data!)
vagrant destroy
```

## Using docker

### Docker environemnt
```bash
export DOCKER_HOST=tcp://192.168.56.2:2375
export DOCKER_TLS_VERIFY=
```

You can use docker within your VM and also outside from your VM (if using MacOS).
All shares and port forwardings are preconfigured.

### Checkout previous docker instance
```bash
git clone git@github.com/path/to/your/installation/
docker-compose up -d
```

... and start your browser and access the exposed port.


### New Projects

Follow the docker-way as defined in the docker manual.
There are already some predefined container from symfony, magento and other projects.

Clone your project layout or just put your files in some directory.

Add docker-compose.yml and add your needed services like (easy example):

```
web:
  build: .
  command: php -S 0.0.0.0:8000 -t /code
  ports:
    - "8000:8000"
  links:
    - db
  volumes:
    - .:/code
db:
  image: orchardup/mysql
  ports:
    - "3306:3306"
  volumes:
    - /var/log/debug:/var/log/debug
  environment:
    MYSQL_DATABASE: app
```

For TYPO3, NEOS or FLOW use the [TYPO3 Docker Boilerplate](https://github.com/mblaschke/typo3-docker-boilerplate)/

Your existing code will be mounted in your web-container and will be executed with the PHP standalone server utility.
If you want to use Nginx or Apache feel free to use own Dockerfiles or existing Web-Containers. Make sure you mount
your files into the right directory.

### Advanced usage

Most of the time you don't need to access your containers, if you still want to just use:

```bash
docker-compose run --rm web bash
docker-compose run --rm db bash
```

### Cli Tools

#### MySQL debugging (live query log and other tools)

If you want to use live query logging you need the '/debug' mount in your mysql container and also an exposed mysql port running on 3306 on the host.

To enable the query log use the provided CliTools:

```bash
ct mysql:debug
```

other debug tools:

```bash
ct mysql:connections
ct mysql:list
ct mysql:restore
ct mysql:drop
ct mysql:create
ct mysql:clear
```

### Services

For [service description (Samba, Mail, IMAP, SSH) see README-SERVICES.md](README-SERVICES.md).

You can use docker-compose the same way as with boot2docker.

### Development

Linux and MacOS users can use shared folders and work locally.

Windows users should use /home/vagrant/code/ (/mnt/data/code/) partition for your files.

## Provisioning

- Repositories
  - Default ubuntu + extras + backports
  - Percona DB
- Packages
  - docker utilts (docker-compose)
  - zsh (default shell, grml config)
  - development tools (colordiff, jq, ack-grep, sloccount)
  - vcs tools (git, git flow, svn, tig)
  - filesystem tools (fuse with sshfs)
  - server tools (ldaputils, swaks,
  - compiler suite (gcc, sass)
  - packaging tools (unrar, unace, 7zip, bzip2)
  - npm (with grunt, gulp and other tools)
  - phars (composer, pack, phpunit)
  - general tools (moreutils, incron, byobu, tmux, netcat, cstream)
  - analysis tools (htop, atop, iftop, mytop, iotop, pfqueue)
  - editors (nano, vim)
  - debugging tools (strace)
  - clitoolbox (as "ct")
- Daemons
  - dnsmasq
  - samba
  - zram
  - haveged
  - postfix and dovecot (user: vagrant, password: vagrant)


## TODO
- Reverse Proxy
  - distributed perverse proxy configuration via shared folders for easy and fast deployment
- auto update composer and stuff? -> ansible tag?
- Vagrantfile
  - private IP-address
  - VAGRANT_VM_DATA_SIZE vmware
  - windows/mac/linux detection
  - https://github.com/BerlinVagrant/vagrant-dns
- move vagrant home to shared folder?
- /etc/host provision
- testing
