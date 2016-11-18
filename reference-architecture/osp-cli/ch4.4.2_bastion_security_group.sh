#!/bin/sh

neutron security-group-create bastion-sg
#
# Bastion:
#  Port/Proto  From      Reason
#
#  22/TCP      anywhere  Secure Shell
neutron security-group-rule-create bastion-sg --protocol icmp
neutron security-group-rule-create bastion-sg \
    --protocol tcp --port-range-min 22 --port-range-max 22
