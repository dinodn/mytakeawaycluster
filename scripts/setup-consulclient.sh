#This script will save Consul client configurations in a json format under systemd
#!/bin/bash
#Define Consul Server IP address
server_ip=10.0.0.10
#Get My IP address
my_ip=`sudo ifconfig enp0s8 | grep "inet addr"|awk -F: '{print $2}'|awk '{print $1}'`
sudo echo -e {"\n""\t"\"advertise_addr\": \"$my_ip\","\n""\t"\"datacenter\": \"docker-cluster\","\n""\t"\"retry_join\": [\"$server_ip\"],"\n""\t"\"encrypt\": \"KnqifJT6qkF0X+Zx9spnjg==\","\n""\t"\"data_dir\": \"/tmp/consul\""\n"} > /etc/systemd/system/consul.d/init.json
