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
}