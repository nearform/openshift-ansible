
#!/bin/sh
#
# Execute these preparation steps on all hosts
# Run on the bastion host
#
OCP_VERSION=${OCP_VERSION:-3.2}
OSP_VERSION=${OSP_VERSION:-8}

export MASTERS="master-0 master-1 master-2"
export INFRA_NODES="infra-node-0 infra-node-1"
export APP_NODES="app-node-0 app-node-1 app-node-2"
export NODES="$INFRA_NODES $APP_NODES"
export ALL_HOSTS="$MASTERS $INFRA_NODES $APP_NODES"

[ -r ./rhn_credentials ] && source ./rhn_credentials

RHN_USERNAME=${RHN_USERNAME:-testuser}
RHN_PASSWORD=${RHN_PASSWORD:-testpass}
RHN_POOL_ID=${RHN_POOL_ID:-''}

sh ch4.8.3_rhn_subscribe_all.sh
#ssh $H sudo subscription-manager register \
#    --username $RHN_USERNAME --password $RHN_PASSWORD
#if [ -n "$POOL_ID" ] ; then
#    ssh $H sudo subscription-manager subscribe --pool $POOL_ID
#fi

sh ch4.8.3_enable_server_repos_all.sh
#ssh $H sudo subscription-manager repos --disable="*"
#ssh $H sudo subscription-manager repos \
#    --enable="rhel-7-server-rpms" \
#    --enable="rhel-7-server-extras-rpms" \
#    --enable="rhel-7-server-optional-rpms"

sh ch4.8.3_enable_ocp_repo_all.sh
#ssh $H sudo subscription-manager repos \
#  --enable="rhel-7-server-ose-${OCP_VERSION}-rpms"

sh ch4.8.3_enable_osp_repos_all.sh
#ssh $H sudo subscription-manager repos \
#  --enable="rhel-7-server-openstack-8-director-rpms" \
#  --enable="rhel-7-server-openstack-8-rpms"

sh ch4.8.3_install_cloud_config_all.sh
#ssh $H sudo yum -y install \
#  os-collect-config \
#  python-zaqarclient \
#  os-refresh-config \
#  os-apply-config
 
#ssh $H sudo systemctl enable os-collect-config
#ssh $H sudo systemctl start --no-block os-collect-config

sh ch4.8.3_enable_eth1_all.sh
#    ssh $H sudo sed -i -e '\$aGATEWAYDEV=eth0' /etc/sysconfig/network
#
#    ssh $H sudo ifup eth1
#    ssh $H sudo /sbin/iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE

sh ch4.8.3_disable_peerdns_eth0_all.sh
#    ssh $H sudo sed -i -e '/PEERDNS/s/=.*/=no/' \
#        /etc/sysconfig/network-scripts/ifcfg-eth0

sh ch4.8.4_enable_lvmetad_nodes.sh
#ssh $H sudo systemctl enable lvm2-lvmetad
#ssh $H sudo systemctl start lvm2-lvmetad
