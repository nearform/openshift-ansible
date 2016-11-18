#!/bin/sh
DOMAIN=${DOMAIN:-ocp3.example.com}
GLANCE_IMAGE=${GLANCE_IMAGE:-rhel72}

for HOSTNUM in 0 1 2 ; do
  nova boot --flavor m1.small --image ${GLANCE_IMAGE} --key-name ocp3 \
   --nic net-name=control-network --nic net-name=tenant-network \
   --security-groups master-sg \
   --user-data=user-data/master-${HOSTNUM}.yaml \
  master-${HOSTNUM}.${DOMAIN}
done
