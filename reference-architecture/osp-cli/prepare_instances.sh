#!/bin/bash
#
# Copy files to the bastion
# Prepare the bastion to configure the rest of the VMs
# 
#
BASTION_HOST=${BASTION_HOST:-bastion.${OCP3_BASE_DOMAIN}}

INSTANCE_FILES="instance_hosts.sh ch4.8.3*_all.sh ch4.8.4_*.sh"

scp -i ${OCP3_KEY_FILE} ${INSTANCE_FILES} cloud-user@${BASTION_HOST}:
ssh -i ${OCP3_KEY_FILE} cloud-user@${BASTION_HOST} sh ./instance_hosts.sh

