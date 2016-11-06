for H in $ALL_HOSTS
do
  ssh $H sudo sed -i -e '/PEERDNS/s/=.*/=no/' \
    /etc/sysconfig/network-scripts/ifcfg-eth0
done
