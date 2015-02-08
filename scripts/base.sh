#!/bin/bash 

# Download and install EPEL repo
rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

# Remove the EPEL rpm file
rm -rf epel-release-*.rpm

# Install Extra Packages for Enterprise Linux (EPEL) repository 
yum install epel-release

# Install Dev Tools for VirtualBox Guest Additions
yum -y install kernel-devel-`uname -r` dkms yum-utils perl bzip2 bzip2-devel