#!/bin/sh
#
set -xue

SCRIPTS=$(dirname $0)

export NAMESERVER=${NAMESERVER:-10.19.114.130}
export DOMAIN=${DOMAIN:-control.ocp3.example.com}

function create_networks() {
    sh ${SCRIPTS}/ch4.3_control_network.sh
    sh ${SCRIPTS}/ch4.3_tenant_network.sh
}

function create_security_groups() {
    sh ${SCRIPTS}/ch4.4.2_bastion_security_group.sh
    sh ${SCRIPTS}/ch4.4.3_master_security_group.sh
    sh ${SCRIPTS}/ch4.4.6_app_node_security_group.sh
    sh ${SCRIPTS}/ch4.4.5_infra_node_security_group.sh
}

function boot_vms() {
    sh ${SCRIPTS}/ch4.5.1_user_data.sh

    sh ${SCRIPTS}/ch4.5.2_boot_bastion.sh
    sh ${SCRIPTS}/ch4.5.3_boot_masters.sh

    sh ${SCRIPTS}/ch4.5.4_cinder_volumes.sh
    
    sh ${SCRIPTS}/ch4.5.5_boot_infra_nodes.sh
    sh ${SCRIPTS}/ch4.5.5_boot_app_nodes.sh

    sh ${SCRIPTS}/ch4.5.6_disable_port_security.sh

    sh ${SCRIPTS}/ch4.5.7_create_floating_ip_addresses.sh
}

create_networks
create_security_groups
boot_vms

sh ${SCRIPTS}/ch4.6_generate_dns_updates.sh

sh ${SCRIPTS}/ch4.7_generate_haproxy_config.sh

# 

