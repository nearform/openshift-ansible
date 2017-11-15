#!/bin/bash
set -euo pipeline

REGION=
AMI=ami-d2cfe8b7
KEY_PAIR=
PUBLIC_HOSTED_ZONE=
GITHUB_ORGANIZATION=
GITHUB_CLIENT_SECRET=
GITHUB_CLIENT_ID=

# TODO: change name folder
mkdir -p /home/centos/.ssh && ssh-keygen -t rsa -N '' -f /home/centos/.ssh/ocp

# Copy SSH config for bastion host
cat >/home/centos/.ssh/config <<EOF
Host *.#{PUBLIC_HOSTED_ZONE}
ProxyCommand               ssh ec2-user@bastion -W %h:%p
IdentityFile               /home/centos/.ssh/ocp

Host bastion
Hostname                   bastion.#{PUBLIC_HOSTED_ZONE}
user                       ec2-user
StrictHostKeyChecking      no
ProxyCommand               none
CheckHostIP                no
ForwardAgent               yes
IdentityFile               /home/centos/.ssh/ocp
EOF

# Set permissions
# TODO: change name folder
cd /home/centos/.ssh && chmod 400 config ocp ocp.pub

# After login, change to openshift-ansible-aws directory
cd /usr/src/openshift-ansible/reference-architecture/aws-ansible

# Run ose-on-aws.py script
# import the variable
./ose-on-aws.py \
--region=$REGION \
--keypair=$KEY_PAIR \
--create-key=yes \
--key-path=/home/centos/.ssh/ocp.pub \
--public-hosted-zone=$PUBLIC_HOSTED_ZONE \
--deployment-type=origin \
--ami=$AMI \
--openshift-metrics-deploy=true \
--github-organization=$GITHUB_ORGANIZATION \
--github-client-secret=$GITHUB_CLIENT_SECRET \
--github-client-id=$GITHUB_CLIENT_ID \
--containerized=true \
--no-confirm && graffiti-monkey --region $REGION
