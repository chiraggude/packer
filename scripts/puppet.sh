#!/bin/bash 

# Install Puppet
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
yum -y install puppet
rm -rf puppetlabs-release-*.rpm



