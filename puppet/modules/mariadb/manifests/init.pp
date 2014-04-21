# Install MariaDB
class mariadb::install {


    package { ["MariaDB-server", "MariaDB-client"]:
		ensure => present,
		require => Package['php-fpm'],
    }
	
		
	file  {	"/etc/my.cnf.d/my.cnf":
			ensure => present,
			owner  => 'mysql',
			group  => 'mysql',
			mode   => 644,
			require => Package["MariaDB-server"],
			source  => "puppet:///modules/mariadb/my.cnf",
	}
	
	service { "mysql":
		ensure  => running,
		require => Package['MariaDB-server'],
		enable  => true,
    }
    
	exec { "set-mysql-password":
    unless => "mysqladmin -u root -pvagrant status",
    command => "mysqladmin -u root password vagrant",
    require => Service["mysql"],
  }
	
	
}
	

	


