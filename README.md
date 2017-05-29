Zephop VM Packer
=================

## Setup

* **Step 1**: Download and install [Packer] (http://www.packer.io/downloads.html), [Vagrant] (https://www.vagrantup.com/downloads.html)  and [VirtualBox] (https://www.virtualbox.org/wiki/Downloads)
* **Step 2**: Clone this repository to a “zhvm-packer” folder
* **Step 3**: Add the folder “zhvm-packer” to the list of environment variables
  * Go to the Control Panel -> System -> Advanced System Settings -> Environment Variables
  * Scroll down in system variables until you find PATH click edit and add the path.
  * Be sure to include a semicolon at the end of the previous path as that is the delimiter.
  * Example:  C:\path;D:\path2;C:\Users\Downloads\zhvm-packer


## Usage

* Download the latest [CentOS 7 64bit ISO](http://isoredirect.centos.org/centos/7/isos/x86_64/) and place it in the “iso” folder
* Run packer:
```
cd zhvm-packer
packer build zhvm.json
```

## ZHVM v1.0 [(download)](#)

* NGINX 1.8.1
* MariaDB 10.1
* PHP-FPM 7.0
* Built with Packer 0.8.6, Vagrant 1.8.1, VirtualBox 5.0.14
* OS: Centos 7.2.1511 x86_x64 Minimal
* CPU: 2 Cores, RAM: 1024MB, HDD: 6GB

Last updated on 15th February, 2016

***

#### Top Tips

* Shutdown Google Drive/Dropbox if they are monitoring the zhvm-packer directory
* All .sh files in “scripts” folder need to have Unix style EOL format
* All .cfg files in “http” folder need to have Unix style EOL format
* On Windows, set Unix style line endings with Notepad++  > Edit > EOL Conversions
* To log the kickstart.cfg file, modify the post-install block > %post --log=/root/ks-post.log
