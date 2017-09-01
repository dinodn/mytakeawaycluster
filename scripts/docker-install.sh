#!/bin/bash
#Function to install Docker 17.06ce
install_docker(){
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
 sudo apt-get update
 sudo apt-get install -y docker-ce
 sudo usermod -aG docker vagrant
}
install_docker
