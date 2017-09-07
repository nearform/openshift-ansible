#!/bin/sh
OSP_VERSION=${OSP_VERSION:-10}
ansible nodes -i inventory -a \
  "subscription-manager repos --enable=rhel-7-server-openstack-${OSP_VERSION}-rpms"

if [ "$OSP_VERSION" -lt 10 ] ; then
  ansible nodes -i inventory -a \
    "subscription-manager repos --enable=rhel-7-server-openstack-${OSP_VERSION}-director-rpms"
fi

