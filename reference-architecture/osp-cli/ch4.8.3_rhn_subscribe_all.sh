for H in $ALL_HOSTS
do
  ssh $H sudo subscription-manager register \
      --username $RHN_USERNAME --password $RHN_PASSWORD
  ssh $H sudo subscription-manager subscribe --pool $RHN_POOL_ID
done
