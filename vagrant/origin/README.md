Overview
--------

This main branch uses Openshift Origin (latest), there is an 'enterprise' branch of this project which uses Openshift Container Platform 3.3 (Openshift Enterprise).

Pre-requisites
--------------

* Vagrant installed ( I run with 1.7.4 which is a bit old)
* VirtualBox installed ( I run with 5.0.14 which is also a bit old)

Install the following vagrant plugins:

* landrush (1.1.2)
* vagrant-hostmanager (1.8.5)

Installation
------------

    git clone https://github.com/petenorth/vagrant-openshift-cluster
    cd vagrant-openshift-cluster
    vagrant up
    vagrant ssh admin1
    su - (when prompted the password is 'redhat')
    /vagrant/deploy.sh (when prompted respond with 'yes' and the password for the remote machines is 'redhat')

An ansible playbook will start (this is openshift installing), it uses the etc_ansible_hosts file of the git repo copied to /etc/ansible/hosts.

The hosts file creates an install with one master and two nodes. The NFS share gets created on admin1.

I think because the vagrant hosts' primary ethernet network card eth0 is that of the host machines the host/ip address resolution doesn't work out of the box meaning that

1. you must click on continue and ignore the problem with the hosts names and ip address resolutions.
2. the /etc/ansible/hosts file makes use of the 'openshift_ip' property to force the use of the eth1 network interface which is using the 192.168.50.x ip addresses of the vagrant private network.

Once complete

Logon to https://master1.example.com:8443 as admin/admin, create a project test then

ssh to master1:

    ssh master1
    oc login -u=system:admin
    oc annotate namespace test openshift.io/node-selector='region=primary' --overwrite

On the host machine (the following assumes RHEL/Centos, other OS may differ) first verify the contents of /etc/dnsmasq.d/vagrant-landrush gives

    server=/example.com/127.0.0.1#10053

then update the dns entries thus

    vagrant landrush set apps.example.com 192.168.50.20

In the web console create a PHP app and wait for it to complete the deployment. Navigate to the overview page for the test app and click on the link for the service i.e.

    cakephp-example-test.apps.example.com
    
What has just been demonstrated? The new app is deployed into a project with a node selector which requires the region label to be 'primary', this means the app gets deployed to either node1 or node2. The landrush DNS wild card entry for apps.example.com points to master1 which is where the router is running, therefore being able to render the home page of the app means that the SDN of Openshift is working properly with Vagrant.

Notes
-----

The landrush plugin creates a small DNS server to that the guest VMs can resolve each others hostnames and also the host can resolve the guest VMs hostnames. The landrush DNS server is listens on 127.0.0.1 on port 10053. It uses a dnsmasq process to redirect dns traffic to landrush. If this isn't working verify that:

    cat /etc/dnsmasq.d/vagrant-landrush

gives

    server=/example.com/127.0.0.1#10053

and that /etc/resolv.conf has an entry

    # Added by landrush, a vagrant plugin 
    nameserver 127.0.0.1

  






  
