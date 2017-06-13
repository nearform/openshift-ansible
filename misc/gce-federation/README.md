# GCE quickstart

## GCE Prerequisites

### Project
The deployment requires a project be configured. Follow the steps using the link below to ensure that a project
is created.

https://cloud.google.com/resource-manager/docs/creating-managing-projects

### DNS
A DNS zone is required for this demo. The link below provides the steps to create the zone.
https://cloud.google.com/dns/quickstart

### Service Account

The deployment requires that a service account be created. If a service account does not exist browse to
https://cloud.google.com/iam/docs/managing-service-accounts#creating_a_service_account

Choose the prefered method API, Console, or GCloud to create the Service Account. Ensure that the project that
will be used for federation is selected.

### GCE.INI

Once the account is created a key must be created. Select the key type of JSON. If using the browser, the
json file will be placed in the home directory under Downloads.

Modify the gce.ini file to represent the values of the service account which will be used for the deployment.

NOTE: Use the value of the email address defined in the JSON file. 

The values below are example values. Modify the values to represent the values defined in the JSON file. 
```
gce_service_account_email_address = deployment@fedconnect-8675309.iam.gserviceaccount.com
gce_service_account_pem_file_path = /home/admin/Downloads/federation-8675309.json
gce_project_id = federation-8675309
```

The values below are example values.
```
export FEDERATION_ID=fed
export FEDERATION_DNS_ZONE=sysdeseng.com
export GCE_CREDS_FILE=/home/admin/Downloads/federation-8675309.json
export GCE_SERVICE_ACCOUNT=deployer
export GCE_PROJECT_ID=federation-8675309
```

### Required Packages
Ensure the following are installed before performing the ansible run.

```
yum -y install ansible
pip install apache-libcloud

```

### Private Key
In the event that your private key for GCE is not the same as the id_rsa on the deployment system then the following must be added to the ansible.cfg

```
private_key_file=/home/admin/.ssh/google_compute_engine
```
### Ansible SSH User
Modify the following locations and specify the ansible_ssh_user. The ansible_ssh_user value will be based on the project-wide SSH keys. 
https://cloud.google.com/compute/docs/instances/adding-removing-ssh-keys

```
vi inventory/group_vars/federation
ansible_ssh_user: admin
```

```
vi templates/inventory.yaml.j2
ansible_ssh_user: admin
```
## Deployment
```
ansible-playbook init.yaml && ./inventory/gce.py --refresh-cache && ansible-playbook install.yaml && ansible-playbook federate.yaml && ansible-playbook deploy-app.yaml 
```

## General Configuration

### Required variables
Variables can be set using extra vars (using -e at the command line) or by export environment variables.

| variable name | env var | description |
|---------------|---------|-------------|
| federation_id | FEDERATION_ID | Unique ID for this federation |

### Optional variables
Variables can be set using extra vars (using -e at the command line) or by export environment variables.

| variable name | env var | default | description |
|---------------|---------|---------|-------------|
|               |         |         |             |

### GCE Provisioning Configuration

GCE Provisioning is enabled when gce_cluster_count > 0

### Required variables

Variables can be set using extra vars (using -e at the command line) or by export environment variables.

| variable name | env var | description |
|---------------|---------|-------------|
| gce_creds_file | GCE_CREDS_FILE | Path to the GCE credentials file to use for provisioning |
| gce_service_account | GCE_SERVICE_ACCOUNT | GCE service account to use for provisioning |
| gce_project_id | GCE_PROJECT_ID | GCE project id to use for provisioning |

### Optional variables

Variables can be set using extra vars (using -e at the command line) or by export environment variables.

| variable name | env var | default | description |
|---------------|---------|---------|-------------|
| gce_cluster_count | GCE_CLUSTER_COUNT | 3 | Number of GCE Clusters to create |
| gce_regions | GCE_REGIONS | us-east1,us-central1,us-west1 | Comma separated list of regions to deploy clusters to |

## Cluster teardown

ansible-playbook teardown.yaml
