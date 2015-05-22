[<-- Back to main section](../README.md)

# Docker


## Init Docker environemnt
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

Hint: With this VM you can use docker and docker-compose the same way like boo2docker.


## New Projects

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
