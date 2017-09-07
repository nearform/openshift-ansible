#!/bin/sh
TENANT_SUBNET_CIDR=${TENANT_SUBNET_CIDR:-172.18.20.0/24}

openstack network create tenant-network
openstack subnet create --network tenant-network \
  --subnet-range ${TENANT_SUBNET_CIDR} --gateway none tenant-subnet
