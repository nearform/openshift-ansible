Overview
--------

This is a Vagrant based project that demonstrates an advanced Openshift Origin Latest or Container Platform 3.3 install i.e. one using an Ansible playbook.

The documentation for the installation process can be found at

https://docs.openshift.org/latest/welcome/index.html

or

https://docs.openshift.com/container-platform/3.3/install_config/install/planning.html


Pre-requisites
--------------

* (If intending to install Openshift Container Platform then) a Red Hat Account is required so that the VM can be registered via subscription manager.
* Vagrant installed ( I run with 1.7.4 which is a bit old)
* VirtualBox installed ( I run with 5.0.14 which is also a bit old)

Install the following vagrant plugins:

* landrush (1.1.2)
* vagrant-hostmanager (1.8.5)
* (If intending to install Openshift Container Platform then) vagrant-registration (found within the Red Hat CDK 2.2)

The Openshift Container Platform install requires importing a RHEL 7.2 box, the easiest way to do this is use the packet tool from hashicorp. The steps are described at

https://stomp.colorado.edu/blog/blog/2015/12/24/on-building-red-hat-enterprise-linux-vagrant-boxes/

The iso image that the vagrant image is created from should be the 'RHEL 7.2 Binary DVD' image on the Red Hat downloads site. The box name I have used in the Vagrantfile is 'rhel/7.2'

When installing Openshift Container Platform the Vagrantfile assumes a Red Hat Employee subscription 'Employee SKU'. If you aren't a Red Hat Employee then simply hard code the Pool ID of the subscription that gives you access to the Openshift Container Platform rpms (this could be a 30 day trial subscription).

Installation
------------

    git clone https://github.com/openshift/openshift-ansible-contrib.git
    cd vagrant-openshift-cluster/vagrant

then for an Origin install

    vagrant up

or for an Openshift Container Platform install

    export DEPLOYMENT_TYPE=enterprise
    vagrant up (you will be prompted for your Red Hat account details and the sudo account password on the host during this process)

then for either carry on with

    vagrant ssh admin1
    su - (when prompted the password is 'redhat')
    /vagrant/deploy.sh (when prompted respond with 'yes' and the password for the remote machines is 'redhat')

An ansible playbook will start (this is openshift installing), it uses the etc_ansible_hosts file of the git repo copied to /etc/ansible/hosts. If installing Openshift Container Platform then (via the DEPLOYMENT_TYPE environment variable) the variable 'deployment_type' in /etc/ansible/hosts is set to 'openshift-enterprise'.

The hosts file creates an install with one master and two nodes. The NFS share gets created on admin1.

The /etc/ansible/hosts file makes use of the 'openshift_ip' property to force the use of the eth1 network interface which is using the 192.168.50.x ip addresses of the vagrant private network.

Once complete AND after confirming that the docker-registry pod is up and running then

Logon to https://master1.example.com:8443 as admin/admin123, create a project test then

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

  






  

