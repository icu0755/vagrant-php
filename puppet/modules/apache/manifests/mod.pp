define apache::mod() {
	exec { "apache2-mod-${name}":
		command => 'a2enmod ${name}',
		path => ['/usr/sbin', '/usr/bin'],
		notify => Service['apache2'],
		require => Package['apache2'];
	}
}