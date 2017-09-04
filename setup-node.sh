#!/bin/bash
# Bash script to create vm using Vagrant, get the input from user to create that many nodes, and check if any stale# disk file already exists on server that may cause vagrant script to fail.

#Function to print messages
print_message(){
 echo "Give the number of nodes needed; eg: setup-node.sh 3 for 3 nodes"
 echo "For Destroying all nodes; setup-node.sh destroy"
 exit
}

#Function to check whether any disk file of docker hosts already exists from previous builds 
check_stale_disk_files(){
count=1
while [ $count -le $1 ]
do
 host=docker-host$count
 if [[ $(vboxmanage list hdds | grep -B4 $host | grep UUID | grep -v base | awk '{print $2}')  ]]; then
  echo "$host disk file already exists. Exiting" 
  exit
 fi
count=$(($count + 1))
done
}

#Check whether any input is given or not
if [ $# -ne "1" ]
then
 print_message
fi
#Check the argument given
if [ $1 == "destroy" ]
then
 echo "Destroying the Vagrant VMs from current working space"
 vagrant halt
 vagrant destroy -f
elif [[ $1 == [0-9] ]]
then
 check_stale_disk_files $1
 echo "Creating $1 Vagrant VMs. Feeding Vagrant VM data to vagrant_hosts.yaml for Vagrantfile to start"
 echo "---" > yaml/vagrant-hosts.yaml
 count=1
 while [ $count -le $1 ]  
  do
   echo "- name: docker-host$count" >> yaml/vagrant-hosts.yaml
   echo "  disk: docker-host$count" >> yaml/vagrant-hosts.yaml
   echo "  ip: 10.0.0.10$count" >> yaml/vagrant-hosts.yaml
#   echo $count
   count=$(($count + 1))
 done 
  vagrant up
  echo "#################################"
  vagrant status
  echo "#################################"
else
 echo "Unknown Option"
 print_message
fi
