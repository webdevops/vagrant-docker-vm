[<-- Back to main section](../README.md)

# CliTools (ct)

## Introduction

[CliTools or ct](https://github.com/mblaschke/clitools) is a executable PHP-Phar for more convienence development. It provides some helpfull tools
eg. for Sniffing, Debugging and Docker controlling.


## MySQL debugging (live query log and other tools)

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