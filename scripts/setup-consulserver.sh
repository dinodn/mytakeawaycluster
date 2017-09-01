#This script will save consul server configurations in json format file under systemd
server_ip=10.0.0.10
sudo echo -e {"\n" "\t"\"server\": true,"\n""\t"\"ui\": true,"\n""\t"\"addresses\": { "\n""\t""\t"\"http\": \"$server_ip\" "\n""\t"}, "\n""\t"\"advertise_addr\": \"$server_ip\","\n""\t"\"client_addr\": \"0.0.0.0\","\n""\t"\"data_dir\": \"/tmp/consul\","\n""\t"\"bootstrap_expect\": 1,"\n""\t"\"encrypt\": \"KnqifJT6qkF0X+Zx9spnjg==\","\n""\t"\"datacenter\": \"docker-cluster\" "\n"} > /etc/systemd/system/consul.d/init.json
