#!/bin/bash

echo "Set up App Server"

# Download and install NGINX repo
rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

# Install and start Nginx
yum -y install nginx
systemctl enable nginx
systemctl start nginx

# Create folder for app
mkdir -p /home/zephop
chown -R nginx:nginx zephop

# Download and install REMI repo for PHP
rpm -ivh http://rpms.remirepo.net/enterprise/remi-release-7.rpm

# Enable Remi and Remi-PHP70 repo
yum-config-manager --enable remi, remi-php70

# Install PHP-FPM
yum -y install php-fpm php-mysqlnd php-mbstring php-mcrypt php-pdo php-gd php-opcache php-cli php-xml php-soap php-imap php-ldap

# Create custom ini file for specific php settings
echo 'post_max_size = 20M
upload_max_filesize = 20M
cgi.fix_pathinfo = 0
max_execution_time = 120
date.timezone = UTC
opcache.enable=1' > /etc/php.d/zephop.ini

# # Configure /etc/php-fpm.d/www.conf
sed -i 's/user = apache/user = nginx/' /etc/php-fpm.d/www.conf
sed -i 's/group = apache/group = nginx/' /etc/php-fpm.d/www.conf
sed -i 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm\/php-fpm.sock/' /etc/php-fpm.d/www.conf
sed -i s'/;listen.owner = nobody/listen.owner = nginx/' /etc/php-fpm.d/www.conf
sed -i s'/;listen.group = nobody/listen.group = nginx/' /etc/php-fpm.d/www.conf
sed -i s'/;listen.mode = 0660/listen.mode = 0660/' /etc/php-fpm.d/www.conf

# PHP folders should be owned by php-fpm process owner
chown nginx:nginx -R /var/lib/php/session

# Start and enable PHP-FPM
systemctl enable php-fpm
systemctl start php-fpm

# Create MariaDB repo file
echo '[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.1/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1' > /etc/yum.repos.d/MariaDB.repo

# Install MariaDB Client
yum -y install MariaDB-client

# Install Supervisor
yum -y install supervisor

# Create ini file for Supervisor configuration
echo '[program:laravel-worker]
process_name=%(program_name)s_%(process_num)02d
command=php /home/zephop/artisan queue:work --sleep=3 --tries=3
autostart=true
autorestart=true
user=nginx
numprocs=4
redirect_stderr=true
stdout_logfile=/home/zephop/storage/logs/worker.log' > /etc/supervisord.d/zephop.ini

# Start Supervisor
systemctl enable supervisord
systemctl start supervisord

# Download and install Composer globally
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Download repo for Git
rpm -ivh http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-1.noarch.rpm
sed -i 's/baseurl=http:\/\/opensource.wandisco.com\/rhel\/6\/git\/$basearch/baseurl=http:\/\/opensource.wandisco.com\/centos\/7\/git\/$basearch/' /etc/yum.repos.d/wandisco-git.repo

# Install Git
yum -y install git

# Download Linux-Dash
git clone https://github.com/afaqurk/linux-dash.git /home/linux-dash

# Download Adminer
mkdir -p /home/adminer
wget https://www.adminer.org/static/download/4.2.4/adminer-4.2.4-en.php -P /home/adminer
wget https://raw.githubusercontent.com/vrana/adminer/master/designs/pepa-linha/adminer.css -P /home/adminer
mv /home/adminer/adminer-4.2.4-en.php /home/adminer/index.php
