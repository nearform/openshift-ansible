#!/bin/sh
neutron security-group-create master-sg

neutron security-group-rule-create master-sg --protocol icmp
neutron security-group-rule-create master-sg --protocol tcp \
        --port-range-min 22 --port-range-max 22 --remote-group-id bastion-sg
for PORT in 53 2379 4789 8053 8443 10250 24224 ; do
    neutron security-group-rule-create master-sg \
            --protocol tcp --port-range-min $PORT --port-range-max $PORT
done

for PORT in 53 4789 8053 8443 24224 ; do
    neutron security-group-rule-create master-sg \
            --protocol udp --port-range-min $PORT --port-range-max $PORT
done

neutron security-group-rule-create master-sg \
     --protocol tcp --port-range-min 2380 --port-range-max 2380 \
     --remote-group-id master-sg
