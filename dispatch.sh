source common.sh

echo -e "\e[32m>>>>>>>>> install golang <<<<<<<\e[0m"
yum install golang -y

echo -e "\e[32m>>>>>>>>> add application user <<<<<<<\e[0m"
useradd ${app_user}

echo -e "\e[32m>>>>>>>>> install golang <<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m>>>>>>>>> download the appication code <<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app
unzip /tmp/dispatch.zip

echo -e "\e[32m>>>>>>>>> download the dependencies <<<<<<<\e[0m"
cd /app
go mod init dispatch
go get
go build

echo -e "\e[32m>>>>>>>>> configure the dispatch service <<<<<<<\e[0m"
cp /root/Roboshop-shell/dispatch.service  /etc/systemd/system/dispatch.service

echo -e "\e[32m>>>>>>>>> Load, Enable and start the service <<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch