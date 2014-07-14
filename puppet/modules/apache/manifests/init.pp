class apache {
    package { 'apache2':
		ensure => latest,
		require => Class['apt'];
	}
	
	service { "apache2":
		enable  => true,
        ensure  => running,
        require => Package["apache2"];
    }
	
	apache::mod { ['rewrite', 'proxy-http']: }
}