#!/bin/bash

# Install Extra Packages for Enterprise Linux (EPEL) repository
yum -y install epel-release

# Install Dev Tools for VirtualBox Guest Additions
yum -y install kernel-devel-`uname -r` dkms yum-utils perl bzip2 bzip2-devel
