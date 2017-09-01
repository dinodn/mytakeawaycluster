# Require YAML module
require 'yaml'
# Setup Consul & Nomad Server VMs
servers = YAML.load_file('yaml/vagrant-servers.yaml')
nodes = YAML.load_file('yaml/vagrant-hosts.yaml')
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#Provisioning Consul & Nomad Server
 servers.each do |server|
  config.vm.define server['name'] do |machine|
   guest_ip = server['ip']
   machine.vm.box = "bento/ubuntu-16.04"
   machine.vm.network "private_network", ip: guest_ip
   machine.vm.hostname = server['name']
   machine.vm.provision :shell, path: "scripts/consul-install.sh", keep_color: "true"
   if server['name'] == "consul-server"
     machine.vm.provision :shell, path: "scripts/setup-consulserver.sh", keep_color: "true"
     machine.vm.provision "shell", inline: "service consul start"
   elsif server['name'] == "nomad-server"
     machine.vm.provision :shell, path: "scripts/nomad-install.sh", keep_color: "true"
     machine.vm.provision :shell, path: "scripts/setup-nomadserver.sh", keep_color: "true"
     machine.vm.provision :shell, path: "scripts/setup-consulclient.sh", keep_color: "true"
     machine.vm.provision "shell", inline: "service consul start"
     machine.vm.provision "shell", inline: "sudo consul join 10.0.0.10"
     machine.vm.provision "shell", inline: "service nomad start"
   else
     print "Need Consul & Nomad Servers"
   end
  end
 end
#Provision Docker Nodes
 nodes.each do |node|
  host_ip=node['ip']
  data_disk=node['disk']+'.vdi'
  config.vm.define node['name'] do |host|
   host.vm.box = "bento/ubuntu-16.04"
   host.vm.network "private_network", ip: host_ip
   host.vm.hostname = node['name']
#  requires the "vagrant-persistent-storage" plugin
#   host.persistent_storage.enabled = true
#   host.vm.provider :virtualbox do |vb|
#    unless File.exist?(data_disk)
   host.persistent_storage.enabled = true
   host.persistent_storage.location = "disk/#{data_disk}"
   host.persistent_storage.size = 2000
   host.persistent_storage.mountname = 'docker'
   host.persistent_storage.filesystem = 'ext4'
   host.persistent_storage.mountpoint = '/var/lib/docker'
#    end
#   end
   host.vm.provision :shell, path: "scripts/docker-install.sh", keep_color: "true"
   host.vm.provision :shell, path: "scripts/consul-install.sh", keep_color: "true"       
   if node['name'] == "docker-host1"
     host.vm.provision :shell, path: "scripts/weave-setup.sh", keep_color: "true"
   else
     host.vm.provision :shell, path: "scripts/weave-attachto-master.sh", keep_color: "true"
   end
   host.vm.provision :shell, path: "scripts/consul-install.sh", keep_color: "true"
   host.vm.provision "shell", path: "scripts/setup-consulclient.sh", keep_color: "true"
   host.vm.provision :shell, path: "scripts/nomad-install.sh", keep_color: "true"
   host.vm.provision "shell", path: "scripts/setup-nomadclient.sh", keep_color: "true"
   host.vm.provision "shell", inline: "service consul start"
   host.vm.provision "shell", inline: "sudo consul join 10.0.0.10"
   host.vm.provision "shell", inline: "service nomad start"
   config.vm.provider "virtualbox" do |guest|
        guest.memory = 1024
        guest.cpus = 1
   end
  end
 end
end
