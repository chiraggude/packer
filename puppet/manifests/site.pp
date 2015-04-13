# default path
Exec { 
			path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] 
}

# Setting a resource default
Package {
      allow_virtual => true,
}

exec { 

	'yum-update':
	  command => 'yum -y update',
			;
	  
	'yum-utils':
	  command => 'yum -y install yum-utils',
			;
  
    	'epel-repo':
			command => 'yum -y install epel-release',
			creates => "/etc/yum.repos.d/epel.repo"
			;
			
	'nginx-repo':
			command => '/bin/rpm -ivh http://nginx.org/packages/centos/7/x86_64/RPMS/nginx-1.6.3-1.el7.ngx.x86_64.rpm',
			creates => "/etc/yum.repos.d/nginx.repo"
			;
			
    	'remi-repo':
			command => '/bin/rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm',
			creates => "/etc/yum.repos.d/remi.repo",
			require => Exec["epel-repo"],
			;
			
	'enable-remi-repo':
			command => 'yum-config-manager --enable remi, remi-php56',
			require => [Exec["remi-repo"], Exec["yum-utils"]],
			;
			
}

yumrepo { 'mariadb-repo':
       name => "mariadb",
	   descr => "MariaDB 10.0",
	   baseurl => "http://yum.mariadb.org/10.0/centos7-amd64/",
	   enabled => "1",
	   gpgcheck => "1",
	   gpgkey => "https://yum.mariadb.org/RPM-GPG-KEY-MariaDB",
}

# Create directory for hosting website
file {  "/home/www":
			ensure => 'directory',
			owner  => 'nginx',
			group  => 'nginx',
			mode   => 750,
			require => Package["nginx"],
			notify  => Service["nginx"],
}

# Adminer
file  {	"/home/www/adminer":
			ensure => directory,
			owner  => 'nginx',
			group  => 'nginx',
			mode   => 644,
			require => Package["nginx"],
			source  => "puppet:///modules/turizon/adminer",
			recurse => true,
}

# Linux-Dash
file { "/home/www/linux-dash" :
      ensure => directory,
      recurse => true,
      owner => "nginx",
      group => "nginx",
      mode => "0770",
	  require => Package["nginx"],
}

# PHP sessions folder (used by Adminer)
file {  "/var/lib/php/session":
			ensure => 'directory',
			recurse => true,
			owner  => 'nginx',
			group  => 'nginx',
			mode   => 770,
			require => Package["nginx", "php-fpm"],
}




class { 'nginx::install': }
class { 'nginx::config': }
class { 'php-fpm::install': }
class { 'php-fpm::config': }
class { 'mariadb::install': }
class { 'turizon::install': }
