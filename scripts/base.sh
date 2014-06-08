#!/bin/bash 

# Download and install EPEL repo and then remove the rpm file
wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
rm -rf epel-release-*.rpm

# Install Dev Tools for VirtualBox Guest Additions
yum -y install kernel-devel-`uname -r` dkms yum-utils perl