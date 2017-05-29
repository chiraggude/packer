#!/bin/bash

echo "Set up Database Server"

# Install and start Redis
yum -y install redis
systemctl enable redis
systemctl start redis

# Create MariaDB repo file
echo '[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.1/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1' > /etc/yum.repos.d/MariaDB.repo

# Install, start and enable MariaDB
yum -y install MariaDB-server
mysql_install_db
systemctl enable mariadb
systemctl start mariadb
