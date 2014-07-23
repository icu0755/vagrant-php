include apt 
include git
include mc
include mysql
include apache
include php

apache::mod { 'rewrite': }

apache::vhost { 'fm.local': 
    docroot => '/var/www/fm/public'
}

host { 'fm.local': 
    ip => '127.0.0.1'
}