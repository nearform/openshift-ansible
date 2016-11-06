for H in $ALL_HOSTS
do
  ssh $H sudo subscription-manager repos --disable="*"
  ssh $H sudo subscription-manager repos \
      --enable="rhel-7-server-rpms" \
      --enable=rhel-7-server-extras-rpms \
      --enable=rhel-7-server-optional-rpms
done
