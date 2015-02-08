#!/bin/bash

echo "Installing VirtualBox guest additions"

VBOX_VERSION=$(cat /home/vagrant/.vbox_version)

mkdir /tmp/vbox
mount -o loop /home/vagrant/VBoxGuestAdditions.iso /tmp/vbox
sh /tmp/vbox/VBoxLinuxAdditions.run
umount /tmp/vbox
rmdir /tmp/vbox
rm -rf /home/vagrant/VBoxGuestAdditions.iso