for H in $NODES
do
  ssh $H sudo yum -y install lvm2
  ssh $H sudo systemctl enable lvm2-lvmetad
  ssh $H sudo systemctl start lvm2-lvmetad
done
