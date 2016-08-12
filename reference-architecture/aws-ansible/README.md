# The Reference Architecture Ansible Script

## Usage
The Ansible script will launch infrastructure and flow straigh into installing the OpenShift application and components.

### Before Launching the Ansible script
Due to the installations use of a bastion server the ssh config must be modified.
```
$ vim /home/user/.ssh/config
Host *.sysdeseng.com
     ProxyCommand               ssh ec2-user@bastion -W %h:%p
     IdentityFile               /path/to/ssh/key

Host bastion
     Hostname                   bastion.sysdeseng.com
     user                       ec2-user
     StrictHostKeyChecking      no
     CheckHostIP                no
     ForwardAgent               yes
     IdentityFile               /path/to/ssh/key

```
### Export the EC2 Credentials
You will need to export your EC2 credentials before attempting to use the
scripts:
```
export AWS_ACCESS_KEY_ID=foo
export AWS_SECRET_ACCESS_KEY=bar
```
### Region
The default region is us-east-1 but can be changed when running the ose-on-aws script by specifying --region=us-west-2 for example.

### New AWS Environment (Greenfield)
When installing into an new AWS environment perform the following.   This will create the SSH key, bastion host, and VPC for the new environment.
```
./ose-on-aws.py --keypair=OSE-key --create-key=yes --key-path=/path/to/ssh/key.pub --rhsm-user=rh-user --rhsm-password=password --public-hosted-zone=sysdeseng.com
```

If the SSH key that you plan on using in AWS already exists then perform the following.
```
./ose-on-aws.py --keypair=OSE-key --rhsm-user=rh-user --rhsm-password=password --public-hosted-zone=sysdeseng.com

```
### Existing AWS Environment (Brownfield)
If installion OpenShift into an existing AWS VPC perfrom the following.  This assumes that you already have a bastion host with the Security Group name of bastion-sg.  The script will prompt for vpc and subnet IDs.
```
./ose-on-aws.py --create-vpc=no --byo-bastion=yes --keypair=OSE-key --rhsm-user=rh-user --rhsm-password=password --public-hosted-zone=sysdeseng.com
```
