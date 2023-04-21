script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[31m>>>>>>>>>>> install python <<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[31m>>>>>>>>>>> add application user <<<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[31m>>>>>>>>>>> create app directory <<<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[31m>>>>>>>>>>> Download the application code to created app directory <<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip

echo -e "\e[31m>>>>>>>>>>> download the dependencies <<<<<<<<\e[0m"
cd /app
pip3.6 install -r requirements.txt

echo -e "\e[31m>>>>>>>>>>> copy payment service <<<<<<<<\e[0m"
cp ${script_Path}/payment.service /etc/systemd/system/payment.service

echo -e "\e[31m>>>>>>>>>>> load, enable and start the payment service <<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl start payment