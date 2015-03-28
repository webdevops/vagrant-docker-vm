#!/bin/bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

export DEBIAN_FRONTEND="noninteractive"

SCRIPT_DIR=$(dirname $(readlink -f "$0"))

########################
# Pre provision provisioning
########################

# install ansible if needed
if [ -z "`which ansible-playbook`" ]; then
   echo " ***************************************************************************** "
   echo " *** Starting installation of ansible "
   echo " ***************************************************************************** "
   apt-get update
   apt-get -q -y --force-yes  install software-properties-common
   apt-add-repository ppa:ansible/ansible
   apt-get -q -y --force-yes update
   apt-get -q -y --force-yes install ansible  python-pycurl python-mysqldb python-passlib
fi

########################
# Provion with ansible
########################

echo " ***************************************************************************** "
echo " *** Starting provision with ansible "
echo " ***************************************************************************** "

ANSIBLE_EXTRA_VARS=""

# fix windows compatiblity
cp -a "$SCRIPT_DIR/ansible/inventory" "/tmp/$$.inventory"
chmod -x -- "/tmp/$$.inventory"

# run ansible
ansible-playbook -v "$SCRIPT_DIR/ansible/playbook.yml" --inventory="/tmp/$$.inventory" --extra-vars="$ANSIBLE_EXTRA_VARS" --tags="bootstrap"

# remove inventory file
rm -f -- "/tmp/$$.inventory"
