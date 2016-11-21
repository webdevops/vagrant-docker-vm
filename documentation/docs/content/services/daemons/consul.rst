======
Consul
======


Every container (with a port) is registred inside Consul with the Registrator service. This allows lookup of the
IP adresses from containers by using following scheme:

``containername-port.service.consul``

With Consul you can eg. connect to a MySQL database with a GUI Tool using an SSH tunnel and this address syntax without
exposing ports to the VM.


DNS lookup examples
-------------------

================================== ====== =========================================
Container name                     Port   DNS name
================================== ====== =========================================
consul                             8500   consul-8500.service.consul
consul                             8600   consul-8600.service.consul
dory-http-proxy                    443    dory-http-proxy-443.service.consul
typo3dockerboilerplate_app_1       80     *error* (underscores not allowed in domain names)
typo3dockerboilerplate_mysql_1     3306   *error* (underscores not allowed in domain names)
================================== ====== =========================================

Note: docker-compose containers are currently not supported, see https://github.com/docker/compose/issues/229
