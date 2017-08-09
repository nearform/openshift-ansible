#!/bin/sh
RHN_USERNAME=${RHN_USERNAME:-changeme}
RHN_PASSWORD=${RHN_PASSWORD:-changeme}
RHN_POOL_ID=${RHN_POOL_ID:-changeme}

for H in $ALL_HOSTS
do
  ssh $H sudo subscription-manager register \
      --username ${RHN_USERNAME} --password ${RHN_PASSWORD}
  ssh $H sudo subscription-manager attach --pool ${RHN_POOL_ID}
done
