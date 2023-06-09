script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[36m>>>>>>> Disable mysql module <<<<<<<<\e[0m"
dnf module disable mysql -y

echo -e "\e[36m>>>>>>> Configuring repo file <<<<<<<<\e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[36m>>>>>>> Install mysql server <<<<<<<<\e[0m"
yum install mysql-community-server -y

echo -e "\e[36m>>>>>>> Enable and start the server <<<<<<<<\e[0m"
systemctl enable mysqld
systemctl start mysqld

echo -e "\e[36m>>>>>>> set sql root password <<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1

echo -e "\e[36m>>>>>>> check the new password working or not <<<<<<<<\e[0m"
mysql -uroot -pRoboShop@1
