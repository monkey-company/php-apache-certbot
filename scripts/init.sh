#!/bin/bash

#set timezone
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#update repo
apt-get update && apt-get upgrade -y

#install dependencies
apt-get install software-properties-common apt-utils wget -y

#install php and dependencies
apt-get install php -y
apt-get install php-dev -y
apt-get install php-pear -y
apt-get install libapache2-mod-php -y

#install apache
apt-get install apache2 -y

#install certbot, sendmail and ssmtp for ssl and mails
add-apt-repository ppa:certbot/certbot -y
apt-get update
apt-get install sendmail -y
apt-get install ssmtp -y
apt install python-certbot-apache -y
