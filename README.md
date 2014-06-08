Turizon VM Packer
==============
## Setup
* **Step 1**: Download and install [Packer] (http://www.packer.io/downloads.html), [Vagrant] (https://www.vagrantup.com/downloads.html)  and [VirtualBox] (http://www.filehippo.com/download_virtualbox/)
* **Step 2**: Clone this repository to a “turizon-packer” folder
* **Step 3**: Add and environment “path” the folder “turizon-packer”. 
  * Go to the Control Panel -> System -> Advanced System Settings -> Environment Variables 
  * Scroll down in system variables until you find PATH click edit and add the path. 
  * Be sure to include a semicolon at the end of the previous path as that is the delimiter. 
  * Example:  C:\path;D:\path2;C:\Users\Downloads\turizon-packer


## Usage
* **Step 1**: Download the [CentOS 6.5 64bit ISO](http://isoredirect.centos.org/centos/6/isos/x86_64/) and place it in the “iso” folder
* **Step 2**: In Command Terminal, change directory to the “turizon-packer” folder and run the following command:
```
packer build tzvm.json
```

## Created with Turizon VM Packer
#### TZVM v1.2 [(download)](https://www.dropbox.com/s/25d8k8f7rl73b75/tzvm.box)
* Centos 6.5 x86_x64
* NGINX 1.6
* MariaDB 10
* PHP-FPM 5.6 
* Built with Packer 0.6.0, Vagrant 1.6.3, VirtualBox 4.3.12
* Provisioned by Puppet 3.6.1
* VirtualBox VM - OS: CentOS 6.5 64bit, CPU: 2 Cores, RAM: 640MB, HDD: 3GB

Last updated on 7th June, 2014

***

#### TZVM-BASE v1.1 [(download)](https://www.dropbox.com/s/1xlwwumeapenihg/tzvm-base.box)
* Centos 6.5 x86_x64
* Built with Packer 0.6.0, Vagrant 1.6.3, VirtualBox 4.3.12
* VirtualBox VM - OS: CentOS 6.5 64bit, CPU: 2 Cores, RAM: 640MB, HDD: 3GB

Last updated on 7th June, 2014

***

#### Top Tips
* Shutdown Google Drive/Dropbox if they are monitoring the turizon-packer directory
* All .sh files in “scripts” folder need to have Unix style EOL format
* All .cfg files in “http” folder need to have Unix style EOL format
* On Windows, set Unix style line endings with Notepad++  > Edit > EOL Conversions
* To log the kickstart.cfg file, modify the post-install block > %post --log=/root/ks-post.log


### Roadmap
* Latest versions of Ruby and RubyGems (required by Puppet)
