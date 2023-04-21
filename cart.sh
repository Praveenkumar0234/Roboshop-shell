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
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip

echo -e "\e[33m>>>>>>>>>>>> change directory to the app <<<<<<<<\e[0m"
cd /app


echo -e "\e[33m>>>>>>>>>>>> Unzip the application code <<<<<<<<\e[0m"
unzip /tmp/cart.zip


echo -e "\e[33m>>>>>>>>>>>> install nodejs dependency <<<<<<<<\e[0m"
npm install

echo -e "\e[33m>>>>>>>>>>>> copy the cart service <<<<<<<<\e[0m"
cp ${script_Path}/cart.service /etc/systemd/system/cart.service

echo -e "\e[33m>>>>>>>>>>>> reload the service <<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[33m>>>>>>>>>>>> enable and start the service <<<<<<<<\e[0m"
systemctl enable cart
systemctl start cart



