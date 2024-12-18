#!/bin/bash

#Настраиваем клиент NFS
echo "Настраиваем Log"

echo "Настроим и проверим время"
sudo timedatectl set-timezone Europe/Moscow
sudo timedatectl
sudo date

echo "Установим утилиты"
sudo apt-get update
sudo apt-get install -y mc
sudo apt-get -y upgrade

sed -i 's/^PasswordAuthentication.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
systemctl restart sshd.service

echo "Проверим, установлен ли Rsyslog"
sudo apt list rsyslog

echo "Скопируем конфиг rsysloga и перезапустим сервис"
sudo cp /vagrant/rsyslog.conf /etc/rsyslog.conf
sudo systemctl restart rsyslog

echo "Проверим порты"
sudo ss -tuln | grep 514
