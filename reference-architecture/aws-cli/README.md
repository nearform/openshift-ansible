# The Reference Architecture Bash Script
The bash scripts provided in this repository will create the infrastucture required to install OpenShift.  Once the
infrastructure is deployed then using the Ansible script in aws-ansible directory will install OpenShift and the required components will be installed.

## Region
The default region is us-east-1.

## Usage
### Setup AWS-cli
```
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y awscli.noarch
yum install -y jq
```
Once the awscli packages have been installed, the AWS CLI needs to be configured. To configure the
AWS Cli peform the following
```
$ aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-east-1
Default output format [None]: ENTER
```

### Setting variables
Variables can be set to customize the OpenShift infrastructure.  Below is a few components of the variable script that should be modified for the OpenShift environment.
```
$ vi /home/user/git/openshift-ansible-contrib/reference-architecture/aws-cli/vars
UNIQ_VAR="prod"
INFRA_DNS=sysdeseng.com
KEY_NAME=OSE-key
```

### Launching the Bash script
```
cd /home/user/git/openshift-ansible-contrib/reference-architecture/aws-cli/vars
./provision-openshift-infra-aws
```

### Post Bash script
Due to the installations use of a bastion server the ssh config must be modified.
```
$ vim /home/user/.ssh/config
Host *.sysdeseng.com
     ProxyCommand               ssh ec2-user@bastion -W %h:%p
     IdentityFile               /home/user/git/openshift-ansible-contrib/reference-architecture/aws-cli/OSE-key.pem

Host bastion
     Hostname                   prod-bastion.sysdeseng.com
     user                       ec2-user
     StrictHostKeyChecking      no
     CheckHostIP                no
     ForwardAgent               yes
     IdentityFile               /home/user/git/openshift-ansible-contrib/reference-architecture/aws-cli/OSE-key.pem

```

### Launching the Installation of Openshift
```
cd ../aws-ansible
ansible-playbook -i inventory/aws/hosts \
-e 'public_hosted_zone=sysdeseng.com \
wildcard_zone=apps.sysdeseng.com \
console_port=8443 \
deployment_type=openshift-enterprise \
rhsm_user=user \
rhsm_password=RHN_PASSWORD \
region=us-east-1 \
openshift_master_cluster_hostname=prod-internal-openshift-master.sysdeseng.com \
openshift_master_cluster_public_hostname=prod-openshift-master.sysdeseng.com \
osm_default_subdomain=apps.sysdeseng.com \
infra_group_tag=tag_prod-role_prod-infra \
app_group_tag=tag_prod-role_prod-app \
master_group_tag=tag_prod-role_prod-master \
s3_username=prod-openshift-s3-docker-registry' \
playbooks/openshift-install.yaml
```
