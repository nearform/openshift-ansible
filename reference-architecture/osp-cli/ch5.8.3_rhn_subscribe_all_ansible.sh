#!/bin/sh
# Pool IDs not yet available
ansible nodes -i inventory -f 1 -m redhat_subscription -a \
        "state=present username=$RHN_USERNAME password=$RHN_PASSWORD"
ansible nodes -i inventory -f 1 -a "subscription-manager attach --pool=${RHN_POOL_ID}"
