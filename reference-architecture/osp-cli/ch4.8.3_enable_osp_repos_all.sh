OSP_VERSION=${OSP_VERSION:-8}
for H in $ALL_HOSTS
do
  ssh $H sudo subscription-manager repos \
      --enable="rhel-7-server-openstack-${OSP_VERSION}-rpms" \
      --enable="rhel-7-server-openstack-${OSP_VERSION}-director-rpms"
done
