#!/bin/sh
OCP3_KEY_FILE=${OCP3_KEY_FILE:-keys/ocp3_rsa}
BASTION_HOST=${BASTION_HOST:-bastion.${OCP3_BASE_DOMAIN}}
scp -i ${OCP3_KEY_FILE} ${OCP3_KEY_FILE} cloud-user@${BASTION_HOST}:.ssh/id_rsa

ssh -i ${OCP3_KEY_FILE} cloud-user@${BASTION_HOST} chmod 600 .ssh/id_rsa
