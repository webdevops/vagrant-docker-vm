#!/usr/bin/env bash

###################
# Find readlink
###################

READLINK='readlink'
unamestr=`uname`
if [ "$unamestr" == 'FreeBSD' -o "$unamestr" == 'Darwin'  ]; then
  READLINK='greadlink'
fi

if [ -z "`which $READLINK`" ]; then
    echo '$READLINK not installed'
fi

###################
# Upsearch
###################

upsearch () {
  slashes=${PWD//[^\/]/}
  directory="$PWD"
  for (( n=${#slashes}; n>0; --n ))
  do
    test -e "$directory/$1" && echo "$directory/" && return
    directory="$directory/.."
    directory="$($READLINK -f "$directory")"
  done
}

###################
# Main
###################


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
