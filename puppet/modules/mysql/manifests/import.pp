define mysql::import() {
	file { "/usr/local/mysql/${name}":
		source  => "puppet:///modules/mysql/${name}",
		owner	=> root,
		group	=> root,
		mode	=> 0600,
		require => File['/usr/local/mysql'],
	}
	
	exec { "mysql-import-${name}":
		command => "mysql -uroot -proot < /usr/local/mysql/${name}",
		path    => ['/bin', '/usr/bin'],
		require => File["/usr/local/mysql/${name}"],
	}
}