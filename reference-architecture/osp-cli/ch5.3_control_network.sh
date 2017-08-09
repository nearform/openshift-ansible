#!/bin/sh
OCP3_DNS_NAMESERVER=${OCP3_DNS_NAMESERVER:-8.8.8.8}
PUBLIC_NETWORK=${PUBLIC_NETWORK:-public_network}
CONTROL_SUBNET_CIDR=${CONTROL_SUBNET_CIDR:-172.18.10.0/24}

openstack network create control-network 
openstack subnet create --network control-network --subnet-range ${CONTROL_SUBNET_CIDR} \
--dns-nameserver ${OCP3_DNS_NAMESERVER} control-subnet
openstack router create control-router
openstack router add subnet control-router control-subnet
neutron router-gateway-set control-router ${PUBLIC_NETWORK}
