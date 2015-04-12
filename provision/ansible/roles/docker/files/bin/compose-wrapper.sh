#!/usr/bin/env bash

upsearch () {
  slashes=${PWD//[^\/]/}
  directory="$PWD"
  for (( n=${#slashes}; n>0; --n ))
  do
    test -e "$directory/$1" && echo "$directory/" && return
    directory="$directory/.."
    directory="$(readlink -f "$directory")"
  done
}

CUR_DIR="$(pwd)"

##
## Search parent directory for docker-compose.yml
##
DOCKER_PATH=$(upsearch docker-compose.yml)
if [ -n "$DOCKER_PATH" ]; then
    cd "$DOCKER_PATH"
    docker-compose $@
else
    echo "No docker-compose.yml found"
    cd "$CUR_DIR"
    exit 1
fi

cd "$CUR_DIR"
