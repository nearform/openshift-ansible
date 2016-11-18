#!/bin/sh
DOMAIN=${DOMAIN:-ocp3.example.com}
GLANCE_IMAGE=${GLANCE_IMAGE:-rhel72}
nova boot --flavor m1.small --image ${GLANCE_IMAGE} --key-name ocp3 \
  --nic net-name=control-network --nic net-name=tenant-network \
  --security-groups bastion-sg \
  --user-data=user-data/bastion.yaml \
  bastion.${DOMAIN}
