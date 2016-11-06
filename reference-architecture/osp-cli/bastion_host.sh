#!/bin/sh
export OSP_VERSION=${OSP_VERSION:-8}
export OCP_VERSION=${OCP_VERSION:-3.2}

cat <<EOF >.ssh/config
StrictHostKeyChecking no
EOF
chmod 600 .ssh/*

[ -r ./rhn_credentials ] && source ./rhn_credentials

sh ch4.8.1_rhn_subscribe.sh

sh ch4.8.1_enable_server_repos.sh

sh ch4.8.1_enable_ocp_repo.sh

sh ch4.8.1_enable_osp_repos.sh

sh ch4.8.1_add_usr_local_bin_to_secure_path.sh

sh ch4.8.1_install_openshift_ansible_playbooks.sh
