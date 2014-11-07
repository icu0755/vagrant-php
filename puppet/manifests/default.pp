import 'apt.pp'

class { 'curl': }

class { 'git': }

class { 'mc': }

class {'composer': }

#import 'mysql.pp'

#class { 'apache': }

#apache::module { 'rewrite': }

#import 'apache-vhost.pp'

#import 'php-apache.pp'

#import 'php-fpm.pp'