script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[33m>>>>>>>>>>>> configure nodejs repo <<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[33m>>>>>>>>>>>> install nodejs <<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[33m>>>>>>>>>>>> Add application user <<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[33m>>>>>>>>>>>> crate directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[33m>>>>>>>>>>>> download Application code  <<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[33m>>>>>>>>>>>> change directory to the app <<<<<<<<\e[0m"
cd /app


echo -e "\e[33m>>>>>>>>>>>> Unzip the application code <<<<<<<<\e[0m"
unzip /tmp/catalogue.zip


echo -e "\e[33m>>>>>>>>>>>> install nodejs dependency <<<<<<<<\e[0m"
npm install

echo -e "\e[33m>>>>>>>>>>>> copy the catalogue service <<<<<<<<\e[0m"
cp /root/Roboshop-shell/catalogue.conf /etc/systemd/system/catalogue.service

echo -e "\e[33m>>>>>>>>>>>> reload the service <<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[33m>>>>>>>>>>>> enable and start the service <<<<<<<<\e[0m"
systemctl enable catalogue
systemctl start catalogue

echo -e "\e[33m>>>>>>>>>>>> copy mongo repo <<<<<<<<\e[0m"
cp /root/Roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[33m>>>>>>>>>>>> install mongo client <<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[33m>>>>>>>>>>>> load the schema <<<<<<<<\e[0m"
mongo --host mongodb-dev.praveendevops.online </app/schema/catalogue.js

