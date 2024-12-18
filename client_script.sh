#!/bin/bash

#Настраиваем сервер CLIENT


echo "Настраиваем сервер CLIENT"
echo "Настроим и проверим время"
sudo timedatectl set-timezone Europe/Moscow
sudo timedatectl
sudo date

echo "Установим утилиты"
sudo apt-get update
sudo apt-get install -y mc sshpass

sudo echo "*.* @192.168.56.11:514" >> /etc/rsyslog.conf
sudo systemctl restart rsyslog
sudo systemctl status rsyslog

echo "Дальше кусок из другой задачи курса. Просто чтобы в системе хоть что-то быстро произошло"

echo "Создаём пользователя otusadm и otus:"
sudo useradd otusadm && sudo useradd otus
echo "Создаём пользователям пароли"
echo -e "otusadm:Test!1" | sudo chpasswd
echo -e "otus:Test!1" | sudo chpasswd
echo "Создаём группу admin"
sudo groupadd -f admin
echo "Добавляем пользователей vagrant,root и otusadm в группу admin"
usermod otusadm -a -G admin && usermod root -a -G admin && usermod vagrant -a -G admin

echo "Посмотрим,что отобразилось на сервере rsyslog"
sshpass -p "vagrant" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@192.168.56.11 "sudo ls -la /var/log/rsyslog/"
sshpass -p "vagrant" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@192.168.56.11 "sudo ls -la /var/log/rsyslog/client"


