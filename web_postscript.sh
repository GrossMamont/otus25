#!/bin/bash
systemctl restart sshd.service
sudo systemctl restart nginx

echo "Потыкаем палочкой в сайт"
for (( i=1; i <= 10; i++ ))
do
curl -Is http://192.168.56.10 | head -n 1
done

echo "Удалим html каталог"
mv /var/www/html/index.nginx-debian.html /var/www/ 

echo "Потыкаем палочкой в несуществующую страницу"
for (( i=1; i <= 10; i++ ))
do
curl -Is http://192.168.56.10 | head -n 1
done

echo "Посмотрим,что отобразилось на сервере Nginx"
echo "Глянем в access.log"
sudo cat /var/log/nginx/access.log
echo "Глянем в error.log"
sudo cat /var/log/nginx/error.log

echo "Посмотрим,что отобразилось на сервере rsyslog"
echo "Глянем в access.log на сервере rsyslog"
sshpass -p "vagrant" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@192.168.56.11 "sudo cat /var/log/rsyslog/web/nginx_access.log"
echo "Глянем в error.log на сервере rsyslog"
sshpass -p "vagrant" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@192.168.56.11 "sudo cat /var/log/rsyslog/web/nginx_error.log"