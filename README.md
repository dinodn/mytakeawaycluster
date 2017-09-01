#1 To Start, run setup-node.sh script with number of docker hosts needed in cluster as an arguemnt.

   If you simply execute setup-node.sh, it will guide you how to execute further.

#2 Entire cluster is built using Vagrant 1.9.8 and Virtualbox 5

   All Vagrant VMs use,
                Ubuntu 16.04

#3 Cluster is formed as follows,
   
   1) Consul Server 
        -Ubuntu 16.04 
        -Consul 0.9.2

   2) Nomad Server
        -Ubuntu 16.04
        -Nomad 0.6.0 

   3) Docker Hosts
        -Ubuntu 16.04
        -Docker 17.06.1-ce

#4 Docker data is mounted to /var/lib/docker as persistent storage using vagrant-persistent-storage Vagrant Plugin

#5 SDN Weave is used for Docker Container Communication

#6 All software installation and setups are done using Bash script. Scripts are saved under scripts/ directory.

#7 Disks for docker hosts will be saved under disk/ directory

   Consul and Nomad service files are stored under service/ directory
 
   yaml files from which vagrant will build vms are saved under yaml/ directory

#8 NOMAD cAdvisor file is saved as cadvisor.nomad. Job can be scheduled on hosts via nomad server using following command on nomad-server,
   vagrant ssh nomad-server
   nomad run /vagrant/cadvisor.nomad
