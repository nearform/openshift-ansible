#!/bin/sh
# Set NAMESERVER to override
NAMESERVER=${NAMESERVER:-8.8.8.8}
neutron net-create control-network
neutron subnet-create --name control-subnet --dns-nameserver ${NAMESERVER} \
  control-network 172.18.10.0/24
neutron router-create control-router
neutron router-interface-add control-router control-subnet
neutron router-gateway-set control-router public_network
