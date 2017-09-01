#This script will create json file for nomad Server
#!/bin/bash
#Get My IP address
my_ip=`sudo ifconfig enp0s8 | grep "inet addr"|awk -F: '{print $2}'|awk '{print $1}'`

sudo echo -e { "\n""\t"\"advertise_addr\": \"$my_ip\","\n""\t"\"bind_addr\": \"0.0.0.0\","\n""\t"\"advertise\": "\n""\t"{"\n""\t""\t"\"rpc\": \"$my_ip:4647\","\n""\t""\t"\"serf\": \"$my_ip:4648\",  "\n""\t"},"\n""\t"\"data_dir\": \"/var/lib/nomad\","\n""\t"\"datacenter\": \"docker-cluster\","\n""\t"\"enable_syslog\": true,"\n""\t"\"syslog_facility\": \"LOCAL0\","\n""\t"\"log_level\": \"INFO\","\n""\t"\"server\": {    "\n""\t""\t"\"bootstrap_expect\": 1,"\n""\t""\t"\"enabled\": true, "\n""\t"}"\n"} > /etc/nomad/nomad.json
