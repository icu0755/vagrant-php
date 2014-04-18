Exec {
    path => '/usr/bin:/bin:/usr/sbin',
}

class apache2 {
    
	package { "apache2":
        name    => "apache2",
        ensure  => "latest",
        require => Class["apt"],
    }
	
	service { "apache2":
        enable  => true,
        ensure  => running,
        require => Package["apache2"],
    }
	
	define vhost($domain) {
        file {
            "webroot-$domain":
                ensure  => directory,
                path    => "/var/www/$domain",
                require => Package["apache2"],
        }

        file { "vhost-$domain":
            path    => "/etc/apache2/sites-available/$domain",
            content => template('/vagrant/manifests/templates/apache/vhost.erb'),
            require => File["webroot-$domain"],
        }

        file { "/etc/apache2/sites-enabled/$domain":
            ensure  => link,
            target  => "/etc/apache2/sites-available/$domain",
            notify  => Service["apache2"],
            require => File["vhost-$domain"],
        }
    }
}

class apt {
    exec { "apt-get update":
        command => "apt-get update",
    }
}

class mc {
    package { "mc":
        name    => "mc",
        ensure  => "latest",
        require => Class["apt"],
    }
}

class mysql {
	$password = "root"
 
    package { "mysql-server":
        name    => "mysql-server",
        ensure  => "latest",
        require => Class["apt"],
    }
	
	exec { "mysqlpassword":
		command 	=> "mysqladmin -uroot password $password",
		subscribe 	=> Package["mysql-server"],
		refreshonly => true,
		unless		=> "mysqladmin -uroot -p$password status",
	}
}

class php {
    package { "libapache2-mod-php5":
        ensure  => "latest",
        require => Package["php5"],
    }

    package { "php-apc":
        ensure  => "latest",
        require => Package["php5"],
    }

    package { "php-pear":
        ensure  => "latest",
        require => Package["php5"],
    }

    package { "php5":
        ensure  => "latest",
        require => Package["apache2"],
    }

    package { "php5-cli":
        ensure  => "latest",
        require => Package["apache2"],
    }

    package { "php5-xdebug":
        ensure   => latest,
        require => Package["php5"],
    }

    package { "php5-mysql":
        ensure  => "latest",
        require => Package["php5"],
    }
}


include apt
include apache2
include mc
include mysql
include php

apache2::vhost{ "alpha.local":
    domain  => "alpha.local",
}
