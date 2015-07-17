#!/bin/bash

set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

export DEBIAN_FRONTEND="noninteractive"
export PYTHONUNBUFFERED=1

SCRIPT_DIR=$(dirname $(readlink -f "$0"))

export ANSIBLE_CONFIG="${SCRIPT_DIR}/ansible/ansible.cfg"

########################
# Maintenance with ansible
########################

echo " ***************************************************************************** "
echo " *** Starting maintenance with ansible "
echo " ***************************************************************************** "

ANSIBLE_EXTRA_VARS=""

# fix windows compatiblity
cp -a "$SCRIPT_DIR/ansible/inventory" "/tmp/$$.inventory"
chmod -x -- "/tmp/$$.inventory"

# run ansible
ansible-playbook "$SCRIPT_DIR/ansible/playbook.yml" --inventory="/tmp/$$.inventory" --extra-vars="$ANSIBLE_EXTRA_VARS" --tags="maintenance"

# remove inventory file
rm -f -- "/tmp/$$.inventory"

########################
# Custom
########################
