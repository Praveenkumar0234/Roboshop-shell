echo -e "\e[34m>>>>>>>>>>> configuring mongo repo <<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[34m>>>>>>>>>>> install mongodb <<<<<<<<<\e[0m"
yum install mongodb-org -y

echo -e "\e[34m>>>>>>>>>>> replace ip address <<<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|g' /etc/mongod.conf

echo -e "\e[34m>>>>>>>>>>> enable and start mongodb <<<<<<<<<\e[0m"
systemctl enable mongod
systemctl start mongod