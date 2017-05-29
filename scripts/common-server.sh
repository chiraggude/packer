#!/bin/bash

echo "Set up Server"

# Update all packages
yum -y update

# Install Extra Packages for Enterprise Linux (EPEL) repository
yum -y install epel-release

# Install Yum utilities
yum -y install yum-utils

# Install miscellaneous utilities
yum -y install wget nano unzip curl

# Set timezone
timedatectl set-timezone UTC

# Set up NTP synchronization service
yum -y install ntp
systemctl start ntpd
systemctl enable ntpd

# Set up Swap file of 2 gigabytes
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
# Make swapfile permanent
echo '/swapfile none swap sw 0 0' >> /etc/fstab
# Add custom Swap settings
echo 'vm.swappiness = 10' >> /etc/sysctl.conf
echo 'vm.vfs_cache_pressure = 50' >> /etc/sysctl.conf
# Reload the sysctl configuration
sysctl -p


# Install Fail2Ban
yum -y install fail2ban
systemctl enable fail2ban
systemctl start fail2ban
# Configure Fail2Ban jail.local file
echo '[DEFAULT]
# Ban hosts for one hour
bantime = 3600

[sshd]
enabled = true' > /etc/fail2ban/jail.local
# Restart Fail2Ban for new settings to take effect
systemctl restart fail2ban
