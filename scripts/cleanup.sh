#!/bin/bash -eux

# Remove Puppet
yum remove -y puppet

# Remove all useless dependencies
yum -y autoremove

# Remove stuff that is needed for building VMware/Virtualbox extensions
yum -y remove gcc cpp kernel-devel kernel-headers
yum -y clean all
history -c
rm -f /etc/ssh/ssh_host_*
rm -f /tmp/*

# Clean up CentOS interface persistence
rm -f /etc/udev/rules.d/70-persistent-net.rules
if [ -r /etc/sysconfig/network-scripts/ifcfg-eth0 ]; then
  sed -i 's/^HWADDR.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0
  sed -i 's/^UUID.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0
fi