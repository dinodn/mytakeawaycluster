#This script will create json file for nomad client on client hosts
#!/bin/bash
#Get My IP address
my_ip=`sudo ifconfig enp0s8 | grep "inet addr"|awk -F: '{print $2}'|awk '{print $1}'`

sudo echo -e { "\n""\t"\"advertise_addr\": \"$my_ip\","\n""\t"\"bind_addr\": \"0.0.0.0\","\n""\t"\"data_dir\": \"/var/lib/nomad\","\n""\t"\"datacenter\": \"docker-cluster\","\n""\t"\"enable_syslog\": true,"\n""\t"\"syslog_facility\": \"LOCAL0\","\n""\t"\"log_level\": \"INFO\","\n""\t"\"client\": "\n""\t"{"\n""\t""\t"\"enabled\": true,"\n""\t""\t"\"network_interface\": \"enp0s8\","\n""\t""\t"\"servers\": [ \"10.0.0.10:4647\" ] "\n""\t"}"\n"} > /etc/nomad/nomad.json
