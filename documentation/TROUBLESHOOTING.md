[<-- Back to main section](../README.md)

# Troubleshooting

## Startup or update errors

### Reprovision the VM

You can safely reprovision your VM:

```bash

# if box is NOT started
vagrant up --provision

# if box is already started
vagrant provision
```

### Windows 10 and VMWare

It can happen that the **Virtual Network Adapters** (in this case host only adapter)
break **on every shutdown** or **disconnect** vom Network.

Windows 10 has **currently issues with Virtual Networks** on different VM Softwares.
With VMWare a Workaround can be reseeting the Network Adapters right before
starting the VM.

1. Shut Down the VM (if not down already)
2. Open VMWare
3. Open in Menu: **Edit > Virtual Network Editor...**
4. Request Admin Rights in this Window (if not already started with them)
5. Click: **Restore Defaults**

This will reset all virtual Network Adapters.
If you now start Vagrant with **vagrant up**, the required Adapters will be
recreated.
