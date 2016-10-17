git clone https://github.com/openshift/openshift-ansible
sudo yum -y install https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
sudo sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo
sudo yum -y --enablerepo=epel install ansible pyOpenSSL

