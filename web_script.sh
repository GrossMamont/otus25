#!/bin/bash

#Настраиваем сервер WEB

echo "Настраиваем сервер WEB"
echo "Настроим и проверим время"
sudo timedatectl set-timezone Europe/Moscow
sudo timedatectl
sudo date

echo "Установим утилиты"
sudo apt-get update
sudo apt-get install -y mc sshpass nginx 

echo "Посмотрим порт 80"
sudo ss -tln | grep 80


