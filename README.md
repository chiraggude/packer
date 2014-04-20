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

