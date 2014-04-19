# Install NGINX
class nginx::install {

    package { "nginx":
		ensure => present,
		require => Exec['nginx-repo']
    }

	service { "nginx":
		ensure  => running,
		require => Package['nginx'],
		enable    => true
    }
	
}

# Configure NGINX	
class nginx::config {
	  
    file {  	"/etc/nginx/nginx.conf":
			ensure => present,
		    owner   => 'root',
			group   => 'root',
			mode    => 600,
			replace => true,
			source  => "puppet:///modules/nginx/nginx.conf",
			require => Package["nginx"],
			notify  => Service["nginx"],
		}
		
	file {	"/etc/nginx/conf.d/virtual.conf":
		    owner   => 'root',
			group   => 'root',
			mode    => 600,
			ensure => present,
			replace => true,
			source  => "puppet:///modules/nginx/virtual.conf",
			require => Package["nginx"],
			notify  => Service["nginx"],
		}


}