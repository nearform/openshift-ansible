for H in $ALL_HOSTS
do
  ssh $H sudo yum -y install \
    os-collect-config python-zaqarclient os-refresh-confi os-apply-config

  ssh $H sudo systemctl enable os-collect-config
  ssh $H sudo systemctl start --no-block os-collect-config
done
