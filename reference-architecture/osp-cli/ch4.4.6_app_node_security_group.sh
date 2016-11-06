#!/bin/sh

neutron security-group-create node-sg

# node:
#   Port/Proto  From      Reason
#  22/TCP       bastion   Secure Shell
#  10250/TCP    master    kubelet??
#  4789/UDP     node      ??
neutron security-group-rule-create node-sg --protocol icmp
neutron security-group-rule-create node-sg --protocol tcp \
        --port-range-min 22 --port-range-max 22 --remote-group-id bastion-sg
neutron security-group-rule-create node-sg \
            --protocol udp --port-range-min 4789 --port-range-max 4789
neutron security-group-rule-create node-sg \
            --protocol tcp --port-range-min 10250 --port-range-max 10250
