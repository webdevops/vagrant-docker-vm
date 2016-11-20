======
Consul
======

Consul/Registrator
------------------

Every container (with a port) is registred inside Consul with the Registrator service. This allows lookup of the
IP adresses from containers by using following scheme:

``containername-port.service.consul``

