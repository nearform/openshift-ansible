#!/bin/sh

for H in $ALL_HOSTS
do
  ssh $H sudo yum install -y wget git net-tools bind-utils iptables-services \
    bridge-utils bash-completion atomic-openshift-excluder \
    atomic-openshift-docker-excluder
done
