Seed Git Server
====================

Seeds a git server with example repositories 

Requirements
------------

This role has dependencies that are not suitable for systems that are part of an OpenShift Cluster as it requires *firewalld* to be installed


Role Variables
--------------

From this role:

| Name                     | Default value |  Description                                 |
|--------------------------|---------------|-------------------------------------------------------------------------------------|
| `openshift_git_repo_home`       |  `{{ git_repo_home }}/openshift`           | Base directory for example repositories |
| `openshift_example_repos` | `[https://github.com/openshift/cakephp-ex.git,https://github.com/openshift/dancer-ex.git,https://github.com/jboss-openshift/openshift-quickstarts.git,https://github.com/openshift/django-ex.git,https://github.com/openshift/nodejs-ex.git,https://github.com/openshift/rails-ex.git]`   | Example repositories to seed into repository    |

Dependencies
------------

* git-server


Example Playbook
----------------

```
- name: Seed git server
  hosts: git-server
  roles:
  - role: seed-git-server
```

Compatibility
------------------

This role was tested and verified with Ansible version `2.1.0.0`

Author Information
------------------

Andrew Block (ablock@redhat.com)