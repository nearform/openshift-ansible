#!/bin/bash
#
# Copy files to the bastion
# Prepare the bastion to configure the rest of the VMs
# 
#
BASTION_HOST=${BASTION_HOST:-bastion.${OCP3_BASE_DOMAIN}}
ssh-keygen -R ${BASTION_HOST}

ssh -o StrictHostKeyChecking=no cloud-user@${BASTION_HOST} true

# copy SSH key
# set SSH key file permissions
sh ch4.8_copy_ssh_key.sh

# copy credentials if present
[ -f rhn_credentials ] &&
    scp -i ${OCP3_KEY_FILE} rhn_credentials cloud-user@${BASTION_HOST}:

# register host and subscribe/attach
BASTION_FILES="bastion_host.sh ch4.8.1_*.sh"
scp -i ${OCP3_KEY_FILE} ${BASTION_FILES} cloud-user@${BASTION_HOST}:

ssh -i ${OCP3_KEY_FILE} cloud-user@${BASTION_HOST} sh ./bastion_host.sh

