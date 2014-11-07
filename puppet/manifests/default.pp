import 'apt.pp'

class { 'apache': }

class { 'curl': }

class { 'git': }

class { 'mc': }

apache::module { 'rewrite': }

class {'composer': }

class {'php::pear':}

class {'php::phpunit':}

import 'vhost.pp'

import 'mysql.pp'

import 'php-apache.pp'