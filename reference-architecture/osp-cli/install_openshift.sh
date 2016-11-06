#!/bin/bash
#
# Push control files and install openshift
#
BASTION_HOST=${BASTION_HOST:-bastion.${OCP3_BASE_DOMAIN}}

ANSIBLE_FILES="ch4.9_*.sh ansible.cfg inventory OSEv3.yml"
OCP_ANSIBLE_ROOT=${OCP_ANSIBLE_ROOT:-/usr/share/ansible}

# generate ansible files

sh ./generate_ansible_config.sh

scp -i ${OCP3_KEY_FILE} ${ANSIBLE_FILES} cloud-user@${BASTION_HOST}:
ssh -i ${OCP3_KEY_FILE} cloud-user@${BASTION_HOST} mkdir -p group_vars
ssh -i ${OCP3_KEY_FILE} cloud-user@${BASTION_HOST} cp OSEv3.yml group_vars

if [ -n "OCP_ANSIBLE_GIT_URL" ] ; then
    ssh -i  ${OCP3_KEY_FILE} cloud-user@${BASTION_HOST} sudo yum -y install git
    ssh -i  ${OCP3_KEY_FILE} cloud-user@${BASTION_HOST} git clone ${OCP_ANSIBLE_GIT_URL}
    OCP_ANSIBLE_ENV="OCP_ANSIBLE_ROOT=${OCP_ANSIBLE_ROOT}"
fi

ssh -i ${OCP3_KEY_FILE} cloud-user@${BASTION_HOST} "${OCP_ANSIBLE_ENV} sh ./ch4.9_deploy_openshift.sh"
ssh -i ${OCP3_KEY_FILE} cloud-user@${BASTION_HOST} sh ./ch4.9_allow_docker_flannel.sh
