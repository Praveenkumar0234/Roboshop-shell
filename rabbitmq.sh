script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[33m>>>>>>>>>>>>> Configure YUM Repos for erlang <<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[33m>>>>>>>>>>>>> install erlang <<<<<<<\e[0m"
yum install erlang -y

echo -e "\e[33m>>>>>>>>>>>>> Configure YUM Repos for rabbitmq <<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[33m>>>>>>>>>>>>> install rabbirmq server <<<<<<<\e[0m"
yum install rabbitmq-server -y

echo -e "\e[33m>>>>>>>>>>>>> enable and start the rabbitmq server <<<<<<\e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo -e "\e[33m>>>>>>>>>>>>> Add user and set permission <<<<<<<\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"