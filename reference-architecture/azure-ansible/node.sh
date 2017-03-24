#!/bin/bash

domain=$(grep search /etc/resolv.conf | awk '{print $2}')

systemctl enable dnsmasq.service
systemctl start dnsmasq.service

#yum -y update
yum -y install wget git net-tools bind-utils iptables-services bridge-utils bash-completion

cat <<EOF > /etc/sysconfig/docker-storage-setup
DEVS=/dev/sdc
VG=docker-vg
EXTRA_DOCKER_STORAGE_OPTIONS="--storage-opt dm.basesize=3G"
EOF

touch /root/.updateok

