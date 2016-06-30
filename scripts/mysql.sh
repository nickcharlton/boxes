#!/bin/bash

# set a root password of "vagrant"
debconf-set-selections <<< "mysql-server mysql-server/root_password password vagrant"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password vagrant"

apt-get install -qy mysql-server libmysqlclient-dev

# enable listening on all addresses
sed -i.bak "s/bind-address\s*= 127.0.0.1/bind-address = 0.0.0.0/g" /etc/mysql/my.cnf

# create a local user which can connect from anywhere
mysql -u root -pvagrant -e "CREATE USER 'vagrant'@'%' IDENTIFIED BY 'vagrant'; GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%' IDENTIFIED BY 'vagrant';"
