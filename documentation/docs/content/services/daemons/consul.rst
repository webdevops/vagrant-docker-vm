======
Consul
======


Every container (with a port) is registred inside Consul with the Registrator service. This allows lookup of the
IP adresses from containers by using following scheme:

``containername-port.service.consul``

With Consul you can eg. connect to a MySQL database with a GUI Tool using an SSH tunnel and this address syntax without
exposing ports to the VM.
