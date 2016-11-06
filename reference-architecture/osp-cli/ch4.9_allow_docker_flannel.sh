#ansible masters -i inventory -m shell \
#  -a 'iptables -A DOCKER -p tcp -j ACCEPT'
ansible nodes -i inventory -m shell \
  -a 'iptables -A DOCKER -p tcp -j ACCEPT'
