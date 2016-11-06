#!/bin/bash
[ -r ./rhn_credentials ] && source ./rhn_credentials
sudo subscription-manager register \
  --username $RHN_USERNAME --password $RHN_PASSWORD
sudo subscription-manager subscribe --pool $RHN_POOL_ID
