ansible nodes -i inventory -a "/usr/sbin/ifup eth1"
ansible nodes -i inventory -a \
        "/usr/sbin/iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE"
