Git Server
====================

Deploys a HTTPD backed Git server

Requirements
------------

This role should not be targeted for systems that are part of an OpenShift Cluster as it requires *firewalld* to be installed

Role Variables
--------------

From this role:

| Name                     | Default value |  Description                                 |
|--------------------------|---------------|-------------------------------------------------------------------------------------|
| `git_repo_home`       |  '/opt/git'            | Root location for Git repositories |
| `git_user` | `git`   | User owning git contents    |
| `git_user_authorized_keys` | `[]`   | List of public keys to be configured as authorized keys for push access to git repositories    |

Dependencies
------------

None

Example Playbook
----------------

```
- name: Creates Git Server
  hosts: git-server
  roles:
  - role: git-server
```

Compatibility
------------------

This role was tested and verified with Ansible version `2.1.0.0`

Author Information
------------------

Andrew Block (ablock@redhat.com)