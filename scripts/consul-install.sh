#!/bin/bash
#Function to Install Cluster
install_consul(){
 wget https://releases.hashicorp.com/consul/0.9.2/consul_0.9.2_linux_amd64.zip
 dpkg -s unzip &>/dev/null || {
	sudo apt-get -y update && sudo apt-get install -y unzip
}
 unzip consul_0.9.2_linux_amd64.zip
 sudo mv consul /usr/local/bin/
 sudo cp /vagrant/service/consul.service /etc/systemd/system/consul.service
 sudo mkdir /etc/systemd/system/consul.d
 rm -rf consul_0.9.2_linux_amd64.zip
}
install_consul 
