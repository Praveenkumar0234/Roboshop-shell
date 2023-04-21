script_path=$(dirname $0)
source ${script_path}/common.sh

echo -e "\e[32m>>>>>>>>>>>> install nginx <<<<<<<<<<<\e[0m]"
yum install nginx -y

echo -e "\e[32m>>>>>>>>>>>> remove nginx content <<<<<<<<<<<\e[0m]"
rm -rf /usr/share/nginx/html/*

echo -e "\e[32m>>>>>>>>>>>> install frontend content <<<<<<<<<<<\e[0m]"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[32m>>>>>>>>>>>> goto the removed nginx content location<<<<<<<<<<<\e[0m]"
cd /usr/share/nginx/html

echo -e "\e[32m>>>>>>>>>>>> unzip frontend content <<<<<<<<<<<\e[0m]"
unzip /tmp/frontend.zip

echo -e "\e[32m>>>>>>>>>>>> copy configuration file <<<<<<<<<<<\e[0m]"
cp ${script_Path}/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[32m>>>>>>>>>>>> enable and start nginx <<<<<<<<<<<\e[0m]"
systemctl enable nginx
systemctl start nginx

