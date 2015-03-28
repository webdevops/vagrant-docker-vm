#!/bin/bash

export DOCKER_HOST=tcp://192.168.56.2:2375
export DOCKER_TLS_VERIFY=

echo "
# Docker settings
export DOCKER_HOST=tcp://192.168.56.2:2375
export DOCKER_TLS_VERIFY=
" > ~/.bashrc > ~/.zshrc