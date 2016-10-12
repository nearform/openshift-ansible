# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'socket'

hostname = Socket.gethostname
localmachineip = IPSocket.getaddress(Socket.gethostname)
puts %Q{ This machine has the IP '#{localmachineip} and host name '#{hostname}'}

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'


# Validate required plugins
REQUIRED_PLUGINS = %w(vagrant-registration vagrant-hostmanager landrush)
errors = []

def message(name)
  "#{name} plugin is not installed, run `vagrant plugin install #{name}` to install it."
end
# Validate and collect error message if plugin is not installed
REQUIRED_PLUGINS.each { |plugin| errors << message(plugin) unless Vagrant.has_plugin?(plugin) }
unless errors.empty?
  msg = errors.size > 1 ? "Errors: \n* #{errors.join("\n* ")}" : "Error: #{errors.first}"
  fail Vagrant::Errors::VagrantError.new, msg
end

centos_box_name = 'rhel/7.2'
NETWORK_BASE = '192.168.50'
INTEGRATION_START_SEGMENT = 20

$miscellany = <<SCRIPT
echo "redhat" | sudo passwd root --stdin
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo service sshd restart

POOL_ID=$(sudo subscription-manager list --available | sed -n '/Employee SKU/,/System Type/p' | grep "Pool ID" | tail -1 | cut -d':' -f2 | xargs)
echo -e $GREEN"Trying PoolID: $POOL_ID"$WHITE
sudo subscription-manager attach --pool=$POOL_ID

sudo subscription-manager repos --disable="*"
subscription-manager repos --enable="rhel-7-server-rpms" --enable="rhel-7-server-extras-rpms" --enable="rhel-7-server-ose-3.3-rpms"
yum -y install wget git net-tools bind-utils iptables-services bridge-utils bash-completion
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
#  config.hostmanager.include_offline = true
 
  config.landrush.enabled = true
  config.landrush.tld = 'example.com'
  config.landrush.guest_redirect_dns = false  

  # vagrant-registration
  if ENV.has_key?('SUB_USERNAME') && ENV.has_key?('SUB_PASSWORD')
    config.registration.username = ENV['SUB_USERNAME']
    config.registration.password = ENV['SUB_PASSWORD']
  end
  
  # Proxy Information from environment
  config.registration.proxy = PROXY = (ENV['PROXY'] || '')
  config.registration.proxyUser = PROXY_USER = (ENV['PROXY_USER'] || '')
  config.registration.proxyPassword = PROXY_PASSWORD = (ENV['PROXY_PASSWORD'] || '')
  config.registration.auto_attach = false

  config.vm.provider "virtualbox" do |v|
     #v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate//vagrant","1"]
     v.memory = 1024
     v.cpus = 1
  end

  config.vm.define :master1 do |master1|
    master1.vm.box = centos_box_name
    #master1.vm.box_url = centos_box_url
    master1.vm.network :private_network, ip: "#{NETWORK_BASE}.#{INTEGRATION_START_SEGMENT}"
    master1.vm.hostname = "master1.example.com"
    master1.vm.provision "shell", inline: "sudo yum -y install httpd-tools"
  end

  config.vm.define :node1 do |node1|
    node1.vm.box = centos_box_name
    #node1.vm.box_url = centos_box_url
    node1.vm.network :private_network, ip: "#{NETWORK_BASE}.#{INTEGRATION_START_SEGMENT + 1}"
    node1.vm.hostname = "node1.example.com"

  end
 
  config.vm.define :node2 do |node2|
    node2.vm.box = centos_box_name
    #node2.vm.box_url = centos_box_url
    node2.vm.network :private_network, ip: "#{NETWORK_BASE}.#{INTEGRATION_START_SEGMENT + 2}"
    node2.vm.hostname = "node2.example.com"

  end

  config.vm.define :admin1 do |admin1|
    admin1.vm.box = centos_box_name
    #admin1.vm.box_url = centos_box_url
    admin1.vm.network :private_network, ip: "#{NETWORK_BASE}.#{INTEGRATION_START_SEGMENT + 3}"
    admin1.vm.hostname = "admin1.example.com"
    admin1.vm.provision "shell", inline: "sudo yum -y install atomic-openshift-utils"
    admin1.vm.provision "shell", inline: "sudo cp -f /vagrant/etc_ansible_hosts /etc/ansible/hosts"

  end

  config.vm.provision "shell", inline: $miscellany

end
