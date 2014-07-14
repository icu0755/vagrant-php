define apache_vhost::vhost($domain, $directory) {
	file {
		"/var/www/${directory}":
			ensure => directory;
			
		"/etc/apache2/sites-available/${domain}.conf":
			content => template('apache_vhost/vhost.erb'),
			require => Package['apache2'],
			notify  => Service['apache2'];

		"/etc/apache2/sites-enabled/${domain}.conf":
			ensure => link,
			target => "/etc/apache2/sites-available/${domain}.conf",
			notify => Service['apache2'];
	}
}