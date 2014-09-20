stage { 'first':
  before => Stage['main'],
} 

class {'apt':
  stage => first,
  always_apt_update => true,
}

class { 'apache': }

class { 'curl': }

class { 'git': }

class { 'mc': }

class { 'mysql': 
    template => "mysql/mysql.conf.erb",
    root_password => 'root',
}

apache::module { 'rewrite': }

mysql::grant { 'allow remote root':
  mysql_privileges => 'ALL',
  mysql_password => 'root',
  mysql_db => '*',
  mysql_user => 'root',
  mysql_host => '%',
}

include php
class {
    # Base packages
    [ 'php::apache' ]:
      ensure => installed;

    # PHP extensions
    [
      'php::extension::curl', 'php::extension::gd', 'php::extension::mcrypt', 'php::extension::mysql', 'php::extension::opcache'
    ]:
      ensure => installed;
  }

# Fixing ubuntu bug
file {'/etc/php5/apache2/conf.d/20-mcrypt.ini':
    notify => Service[apache],
    ensure => link,
    target => '../../mods-available/mcrypt.ini',
    require => Package['php5-mcrypt'],
}

file {'/etc/php5/cli/conf.d/20-mcrypt.ini':
    ensure => link,
    target => '../../mods-available/mcrypt.ini',
    require => Package['php5-mcrypt'],
}


class {'composer': }