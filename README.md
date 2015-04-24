Turizon VM Packer
=================

## Setup

* **Step 1**: Download and install [Packer] (http://www.packer.io/downloads.html), [Vagrant] (https://www.vagrantup.com/downloads.html)  and [VirtualBox] (http://www.filehippo.com/download_virtualbox/)
* **Step 2**: Clone this repository to a “turizon-packer” folder
* **Step 3**: Add the folder “turizon-packer” to the list of environment variables 
  * Go to the Control Panel -> System -> Advanced System Settings -> Environment Variables 
  * Scroll down in system variables until you find PATH click edit and add the path. 
  * Be sure to include a semicolon at the end of the previous path as that is the delimiter. 
  * Example:  C:\path;D:\path2;C:\Users\Downloads\turizon-packer


## Usage

* Download the [CentOS 7 64bit ISO](http://isoredirect.centos.org/centos/7/isos/x86_64/) and place it in the “iso” folder
* Run packer:
```
cd turizon-packer
packer build tzvm.json
```

## Built with VM Packer

#### TZVM v1.5 [(download)](https://www.dropbox.com/s/25d8k8f7rl73b75/tzvm.box)
* Centos 7 x86_x64
* NGINX 1.6.3
* MariaDB 10.0
* PHP-FPM 5.6 
* Built with Packer 0.7.5, Vagrant 1.7.2, VirtualBox 4.3.20
* Provisioned by Puppet 3.7.4
* VirtualBox VM - OS: CentOS 7 64bit, CPU: 2 Cores, RAM: 1024MB, HDD: 6GB

Last updated on 13th April, 2015

***


#### Top Tips
* Shutdown Google Drive/Dropbox if they are monitoring the turizon-packer directory
* All .sh files in “scripts” folder need to have Unix style EOL format
* All .cfg files in “http” folder need to have Unix style EOL format
* On Windows, set Unix style line endings with Notepad++  > Edit > EOL Conversions
* To log the kickstart.cfg file, modify the post-install block > %post --log=/root/ks-post.log
