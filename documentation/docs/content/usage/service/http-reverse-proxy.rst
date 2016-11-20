===============================
HTTP/web (dinghy reverse proxy)
===============================

The default reverse proxy registers automatically any Docker container with ``VIRTUAL_HOST`` and ``VIRUTAL_PORT`` to
it's configuration so multiple containers are accessable from outside without using other ports.

Also containers from docker-compose are registerd by this reverse proxy: ``project_app_1`` -> ``app.project.docker``

For more informations visit: https://github.com/codekitchen/dinghy-http-proxy

=============== =======================
Setting         Value
=============== =======================
Hostname        *.docker
Port            80 and 443
=============== =======================
