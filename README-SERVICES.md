[<-- Back to main section](README.md)

# Services

## HTTP/Web

Setting               | Value
--------------------- | -------------
Hostname              | *.vm
Port                  | 80 or 443 (ssl with ssl-proxy, no cert check)

## SSH

```bash
vagrant ssh

# or

ssh vagrant@192.168.56.2
```

Setting               | Value
--------------------- | -------------
Server                | IP or Hostname of VM (192.168.56.2)
Port                  | 22
Username              | vagrant
Password              | vagrant
SSH Key               | Automatically deployed from github, if account name is set (see vm.yml)

## Samba (SMB, CIFS)

    \\192.168.56.2\code


Setting               | Value
--------------------- | -------------
Server                | IP or Hostname of VM (192.168.56.2)
User                  | vagrant
Password              | vagrant
<br>                  |
Share /vagrant        | /home/vagrant
Share /code           | /mnt/code/
Share /tmp            | /tmp/


MacOS and Linux don't need Samba, Vagrant will use shared folders.

For MacOS the /Users directory will be mounted under /Users in Vagrant VM to enable
transparent external docker access.

## Mail

IMAP Settings         | Value
--------------------- | -------------
Server                | IP or Hostname of VM (192.168.56.2)
Port                  | 143 (without ssl)
Username              | vagrant
Password              | vagrant

SMTP Settings         | Value
--------------------- | -------------
Server                | IP or Hostname of VM (192.168.56.2)
Port                  | 25

Any outgoing email is catched by postfix and send to mailbox of vagrant user.
