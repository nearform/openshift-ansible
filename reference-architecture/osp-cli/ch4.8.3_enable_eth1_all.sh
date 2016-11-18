for H in $ALL_HOSTS
do
  ssh $H sudo sed -i -e '\$aGATEWAYDEV=eth0' /etc/sysconfig/network

  ssh $H sudo ifup eth1
  ssh $H sudo /sbin/iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
done
