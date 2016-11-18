OCP_VERSION=${OCP_VERSION:-3.2}
for H in $ALL_HOSTS
do
  ssh $H sudo subscription-manager repos \
      --enable="rhel-7-server-ose-${OCP_VERSION}-rpms" 
done
