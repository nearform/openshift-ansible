POOL_ID=$(sudo subscription-manager list --available | sed -n '/Employee SKU/,/System Type/p' | grep "Pool ID" | tail -1 | cut -d':' -f2 | xargs)
echo -e $GREEN"Trying PoolID: $POOL_ID"$WHITE
sudo subscription-manager attach --pool=$POOL_ID

sudo subscription-manager repos --disable="*"
sudo subscription-manager repos --enable="rhel-7-server-rpms" --enable="rhel-7-server-extras-rpms" --enable="rhel-7-server-ose-3.3-rpms"
