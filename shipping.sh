echo -e "\e[34m>>>>>>>>>> install maven <<<<<<<<<<\e[0m"
yum install maven -y

echo -e "\e[34m>>>>>>>>>> add application user <<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[34m>>>>>>>>>> Crate app directory <<<<<<<<<<\e[0m"
rm rf /app
mkdir /app

echo -e "\e[34m>>>>>>>>>> download the shipping application code <<<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip

echo -e "\e[34m>>>>>>>>>> change directory and unzip the application code  <<<<<<<<<<\e[0m"
cd /app
unzip /tmp/shipping.zip

echo -e "\e[34m>>>>>>>>>> Install dependencies <<<<<<<<<<\e[0m"
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[34m>>>>>>>>>> setup the shipping service <<<<<<<<<<\e[0m"
cp /root/Roboshop-shell/shipping.service /etc/systemd/system/shipping.service

echo -e "\e[34m>>>>>>>>>> reload, enable and start the shipping service <<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping

echo -e "\e[34m>>>>>>>>>> Install mysql client <<<<<<<<<<\e[0m"
yum install mysql -y

echo -e "\e[34m>>>>>>>>>> load mysql schema <<<<<<<<<<\e[0m"
mysql -h mysql-dev.praveendevops.online -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[34m>>>>>>>>>> restart shipping service <<<<<<<<<<\e[0m"
systemctl restart shipping