# Install Turizon Dev Tools

class turizon::install {

    exec { 
	
		'install-git': command => 'yum -y install git';
	
		'install-composer': command => 'curl -sS https://getcomposer.org/installer | php', require => Package["php-fpm"];
		
		'make-composer-global': command => 'mv composer.phar /usr/local/bin/composer', require => Exec["install-composer"];
		  
		'install-nodejs': command => 'yum -y install nodejs';
		
		'install-npm': command => 'yum -y install npm', require => Exec["install-nodejs"];
		
		'install-bower': command => 'npm install -g bower', require => Exec["install-npm"];
		
		'install-gulp': command => 'npm install -g gulp', require => Exec["install-npm"];
		
		'download-linux-dash': command => 'git clone https://github.com/afaqurk/linux-dash.git /home/www/linux-dash', require => Exec["install-git"];
				
	  
	}
	
}