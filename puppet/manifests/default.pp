import 'apt.pp'

class { 'apache': }

apache::module { 'rewrite': }

class { 'curl': }

class { 'git': }

class { 'mc': }

class {'composer': }

import 'vhost.pp'

import 'mysql.pp'

#import 'php-apache.pp'

import 'php-fpm.pp'