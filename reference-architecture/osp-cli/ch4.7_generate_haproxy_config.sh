#!/bin/bash
#
#
OCP3_BASE_DOMAIN=${OCP3_BASE_DOMAIN:-ocp3.example.com}
HAPROXY_TEMPLATE=${HAPROXY_TEMPLATE:-haproxy.cfg.template}
HAPROXY_CONF=${HAPROXY_CONF:-haproxy.cfg.new}

HAPROXY_HOST=${HAPROXY_HOST:-10.0.0.20}
HAPROXY_USER=${HAPROXY_USER:-cloud-user}
HAPROXY_KEY=${HAPROXY_KEY:-service_rsa}


INDENT="\ \ \ \ " # sed append wants leading spaces escaped

function server_line() {
    # $1=HOSTNAME
    # $2=DOMAIN
    # $3=IPADDR
    # $4=PORT
    echo "server $1.$2 $3:$4 check"
}

function master_hosts() {
  nova list --field name,networks | grep master | awk '{print $4":"$8}'
}

function infra_hosts() {
 nova list --field name,networks | grep infra-node | awk '{print $4":"$8}'
}

function host_name() {
  # FQDN=$1
  echo "$1" | cut -d. -f1
}

cp $HAPROXY_TEMPLATE $HAPROXY_CONF
for HOST_RECORD in $(master_hosts) ; do
  HOSTNAME=$(host_name $(echo $HOST_RECORD | cut -d: -f1))
  IPADDR=$(echo $HOST_RECORD | cut -d: -f2)
  sed -i \
    -e "/MASTERS/a${INDENT}$(server_line $HOSTNAME $OCP3_BASE_DOMAIN $IPADDR 8443)" \
    $HAPROXY_CONF
done

for HOST_RECORD in $(infra_hosts) ; do
  HOSTNAME=$(host_name $(echo $HOST_RECORD | cut -d: -f1))
  IPADDR=$(echo $HOST_RECORD | cut -d: -f2)
  sed -i \
    -e "/INFRA_80/a${INDENT}$(server_line $HOSTNAME $OCP3_BASE_DOMAIN $IPADDR 80)" \
    $HAPROXY_CONF
  sed -i \
    -e "/INFRA_443/a${INDENT}$(server_line $HOSTNAME $OCP3_BASE_DOMAIN $IPADDR 443)" \
    $HAPROXY_CONF
done

scp -i ${HAPROXY_KEY} ${HAPROXY_CONF} ${HAPROXY_USER}@${HAPROXY_HOST}:haproxy.cfg
ssh -i ${HAPROXY_KEY} ${HAPROXY_USER}@${HAPROXY_HOST} \
    sudo cp haproxy.cfg /etc/haproxy
ssh -i ${HAPROXY_KEY} ${HAPROXY_USER}@${HAPROXY_HOST} \
    sudo systemctl restart haproxy

rm ${HAPROXY_CONF}
