#!/bin/sh
OCP3_DOMAIN=${OCP3_DOMAIN:-ocp3.example.com}

MASTERS="master-0 master-1 master-2"
INFRA_NODES="infra-node-0 infra-node-1"
APP_NODES="app-node-0 app-node-1 app-node-2"
ALL_NODES="$INFRA_NODES $APP_NODES"
ALL_HOSTS="$BASTION $MASTERS $ALL_NODES"

for HOST in bastion $MASTERS $INFRA_NODES
do
  FLOATING_IP=$(nova floating-ip-create public_network | \
    grep public_network | awk '{print $4}')
  nova floating-ip-associate ${HOST}.control.${OCP3_DOMAIN} ${FLOATING_IP}
done
