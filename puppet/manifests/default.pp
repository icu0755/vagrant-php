class { 'apache': }

class { 'apt': }

class { 'curl': }

class { 'git': }

class { 'mc': }

class { 'mysql': 
    template => "mysql/mysql.conf.erb",
    root_password => 'root',
}

class { 'php': }

apache::module { 'rewrite': }

mysql::grant { 'allow remote root':
  mysql_privileges => 'ALL',
  mysql_password => 'root',
  mysql_db => '*',
  mysql_user => 'root',
  mysql_host => '%',
}

php::module { ['gd', 'mcrypt', 'mysql', 'xdebug']: }

# Fixing ubuntu bug
file {'/etc/php5/apache2/conf.d/20-mcrypt.ini':
    notify => Service[apache],
    ensure => link,
    target => '../../mods-available/mcrypt.ini',
}

file {'/etc/php5/cli/conf.d/20-mcrypt.ini':
    ensure => link,
    target => '../../mods-available/mcrypt.ini',
}


class {'composer': }