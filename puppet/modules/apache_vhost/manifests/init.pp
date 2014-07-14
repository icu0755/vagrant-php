class apache_vhost {
	file { '/var/www':
		ensure => directory;
	}
}