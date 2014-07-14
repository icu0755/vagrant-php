class php {
    package { 
		["php5",
		"php5-cli",
		"libapache2-mod-php5",
		"php-apc",
		"php-pear",
		"php5-mysql",
		"php5-xdebug"]:
        ensure  => "latest",
        require => [Class['apt'], Class['apache']];
	}
	
	file { "/etc/php5/mods-available/xdebug.ini":
		source  => "puppet:///modules/php/xdebug.ini",
		owner	=> root,
		group	=> root,
		mode	=> 0644,
		require => Package['php5-xdebug'];
	}
}