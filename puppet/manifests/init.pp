# default path
Exec { 
			path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] 
}

exec { 

	'yum-update':
	  command => 'yum -y update',
	  ;
  
    'nginx-repo':
			command => '/bin/rpm -ivh http://nginx.org/packages/rhel/6/noarch/RPMS/nginx-release-rhel-6-0.el6.ngx.noarch.rpm',
			creates => "/etc/yum.repos.d/nginx.repo"
			;
			
     'remi-repo':
			command => '/bin/rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm',
			creates => "/etc/yum.repos.d/remi.repo"
			;
			
	 'enable-remi-repo':
	  command => 'yum-config-manager --enable remi, remi-php56',
	  require => Exec["remi-repo"],
	  ;
  
}

yumrepo { 'mariadb-repo':
       name => "mariadb",
	   descr => "MariaDB 10.0",
	   baseurl => "http://yum.mariadb.org/10.0/centos6-amd64",
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

file  {	"/home/www/index.php":
			ensure => present,
			owner  => 'nginx',
			group  => 'nginx',
			mode   => 750,
			require => Package["nginx"],
			source  => "puppet:///modules/turizon/index.php",
}

# Adminer
file {  "/home/www/adminer":
			ensure => 'directory',
			owner  => 'nginx',
			group  => 'nginx',
			mode   => 750,
			require => Package["nginx"],
			notify  => Service["nginx"],
}


file  {	"/home/www/adminer/adminer-4.1.0-en.php":
			ensure => present,
			owner  => 'nginx',
			group  => 'nginx',
			mode   => 644,
			require => Package["nginx"],
			source  => "puppet:///modules/turizon/adminer/adminer-4.1.0-en.php",
}

#Linux-Dash
file { "/home/www/linux-dash" :
      ensure => directory,
      source => "puppet:///modules/turizon/linux-dash",
      recurse => true,
      owner => "nginx",
      group => "nginx",
      mode => "0770",
}



# PHP sessions (used by Adminer)
file {  "/var/lib/php/session":
			ensure => 'directory',
			recurse => true,
			owner  => 'nginx',
			group  => 'nginx',
			mode   => 770,
			require => Package["nginx", "php-fpm"],
			source => "puppet:///modules/php-fpm/session",
}

# Logs
file  {	"/home/logs":
			ensure => 'directory',
			recurse => true,
			owner  => 'root',
			group  => 'root',
			mode   => 750,
			source  => "puppet:///modules/turizon/logs",
			before => Package['nginx'],
}

class { 'nginx::install': }
class { 'nginx::config': }
class { 'php-fpm::install': }
class { 'php-fpm::config': }
class { 'mariadb::install': }
