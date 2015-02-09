# Install Turizon Dev Tools

class turizon::install {

    exec { 
	
		'install-git': command => 'yum -y install git';
	
		'install-composer': command => 'curl -sS https://getcomposer.org/installer | php', require => Package["php-fpm"];
		
		'make-composer-global': command => 'mv composer.phar /usr/local/bin/composer', require => Exec["install-composer"];
		
		'download-linux-dash': command => 'git clone https://github.com/afaqurk/linux-dash.git /home/www/linux-dash', require => Exec["install-git"];
				
	  
	}
	
}