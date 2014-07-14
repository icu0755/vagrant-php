class mysql {
  package { ['mysql-server']:
    ensure => present,
	require => Class['apt'];
  }

  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server'];
  }

  file { '/etc/mysql/my.cnf':
    source  => 'puppet:///modules/mysql/my.cnf',
    require => Package['mysql-server'],
    notify  => Service['mysql'],
	owner	=> root,
	group	=> root,
	mode	=> 0600;
  }

  exec { 'set-mysql-password':
    unless  => 'mysqladmin -uroot -proot status',
    command => "mysqladmin -uroot password root",
    path    => ['/bin', '/usr/bin'],
    require => Service['mysql'];
  }
  
  file { '/usr/local/mysql': 
	ensure => directory,
	owner	=> root,
	group	=> root,
	mode	=> 0755,
	require => Exec['set-mysql-password'];
  }
  
  file { '/usr/local/mysql/remote-access.sql':
	source  => 'puppet:///modules/mysql/remote-access.sql',
	owner	=> root,
	group	=> root,
	mode	=> 0600,
	require => File['/usr/local/mysql'],
  }

  exec { 'mysql-remote-access':
    require => File['/usr/local/mysql/remote-access.sql'],
	command => "mysql -uroot -proot < /usr/local/mysql/remote-access.sql",
    path    => ['/bin', '/usr/bin'],
  }
}
