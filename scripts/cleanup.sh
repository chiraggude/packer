#!/bin/bash -eux
# These were only needed for building VMware/Virtualbox extensions:
yum -y remove gcc cpp kernel-devel kernel-headers
yum -y clean all
history -c
rm -f /etc/ssh/ssh_host_*
rm -f /tmp/*

# clean up redhat interface persistence
rm -f /etc/udev/rules.d/70-persistent-net.rules
sed -i 's/^HWADDR.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0
sed -i 's/^UUID.*$//' /etc/sysconfig/network-scripts/ifcfg-eth0