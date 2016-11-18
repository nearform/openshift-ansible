#!/bin/sh
DOMAIN=${DOMAIN:-ocp3.example.com}
GLANCE_IMAGE=${GLANCE_IMAGE:-rhel72}
for HOSTNAME in app-node-0 app-node-1 app-node-2
do
  VOLUMEID=$(cinder show ${HOSTNAME}-docker | grep ' id ' | awk '{print $4}')
  
  nova boot --flavor m1.medium --image ${GLANCE_IMAGE} --key-name ocp3 \
   --nic net-name=control-network --nic net-name=tenant-network \
   --security-groups node-sg \
   --block-device source=volume,dest=volume,device=vdb,id=${VOLUMEID} \
   --user-data=user-data/${HOSTNAME}.yaml \
   ${HOSTNAME}.${DOMAIN}
done
