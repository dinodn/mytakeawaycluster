#This script will install NOMAD on hosts
install_nomad(){
NOMAD_VERSION=0.6.0
curl -sSL https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip -o nomad.zip
unzip nomad.zip 
sudo install nomad /usr/bin/nomad
sudo mkdir -p /etc/nomad
sudo chmod a+w /etc/nomad
sudo cp /vagrant/service/nomad.service /etc/systemd/system/nomad.service
rm -rf nomad.zip
}
install_nomad
