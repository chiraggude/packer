# Install PHP-FPM
class php-fpm::install {

    package { "php-fpm":
		ensure => present,
		require => Exec['enable-remi-repo']
    }
	
	$php_modules = ["php-pdo", "php-mysqlnd", "php-soap", "php-gd", "php-imap", "php-ldap", "php-mbstring", "php-mcrypt"]
	
	package { $php_modules: 
			ensure => "installed",
			require => Package['php-fpm']
	}

	service { "php-fpm":
		require => Package['php-fpm'],
		ensure => "running",
		enable  => true,
    }
}
	
# Configure PHP-FPM
class php-fpm::config {

	file { "/etc/php-fpm.d/www.conf":
			ensure => present,
		    owner   => 'root',
			group   => 'root',
			mode    => 600,
			replace => true,
			source  => "puppet:///modules/php-fpm/www.conf",
			require => Package["nginx"],
			notify  => Service["php-fpm"],
		}
	
		   
	  
	file {'/etc/php.d/cpg.ini':
		  #notify  => Service["php-fpm"],
		  ensure => present,
		  owner => root, group => root, mode => 444,
		  content => "post_max_size = 20M \nupload_max_filesize = 20M \ncgi.fix_pathinfo = 0 \nmax_execution_time = 120 \n",
		  require => Package['php-fpm'],		  
	}
	
	exec { 'restart-php-fpm':
	  command => 'service php-fpm restart',
	  require => File['/etc/php.d/cpg.ini'],
	}
	
	
 
}
	


