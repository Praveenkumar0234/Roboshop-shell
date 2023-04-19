echo -e "\e[32m>>>>>>>>>>> Configuring redis repo<<<<<<<<<\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[32m>>>>>>>>>>> enable 6.2 module <<<<<<<<<\e[0m"
dnf module enable redis:remi-6.2 -y

echo -e "\e[32m>>>>>>>>>>> Install redis <<<<<<<<<\e[0m"
yum install redis -y

echo -e "\e[32m>>>>>>>>>>> replace the listen address <<<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|g' /etc/redis.conf

echo -e "\e[32m>>>>>>>>>>> enable and start the redis <<<<<<<<<\e[0m"
systemctl enable redis
systemctl start redis

