#!/bin/sh

neutron security-group-create infra-sg

# infra
neutron security-group-rule-create infra-sg --protocol icmp
neutron security-group-rule-create infra-sg --protocol tcp \
        --port-range-min 22 --port-range-max 22 --remote-group-id bastion-sg

neutron security-group-rule-create infra-sg --protocol tcp \
        --port-range-min 5000 --port-range-max 5000 --remote-group-id infra-sg
neutron security-group-rule-create infra-sg --protocol tcp \
        --port-range-min 5000 --port-range-max 5000 --remote-group-id node-sg

for PORT in 80 443 10250 ; do
    neutron security-group-rule-create infra-sg \
            --protocol tcp --port-range-min $PORT --port-range-max $PORT
done
neutron security-group-rule-create infra-sg \
            --protocol tcp --port-range-min 4789 --port-range-max 4789
