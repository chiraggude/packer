#!/bin/bash 


wget http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-10.noarch.rpm
rpm -ivh puppetlabs-release-6-10.noarch.rpm
yum -y install puppet
rm -rf puppetlabs-release-*.rpm



