# Install MariaDB
class mariadb::install {

	$pass = "vagrant"

    package { ["MariaDB-server", "MariaDB-client"]:
		ensure => present,
		require => Package['php-fpm'],
    }
	
	service { "mysql":
		ensure  => running,
		require => Package['MariaDB-server'],
		enable  => true,
    }
    
	exec { "set-mysql-password":
    unless => "mysqladmin -uroot -p$pass status",
    command => "mysqladmin -uroot password $pass",
    require => Service["mysql"],
  }
	
	
}
	

	


