apache::vhost { 'example.com':
    docroot => '/var/www/example.com',
    docroot_create => true,
    env_variables => ['APP_ENV dev'],
    directory => '/var/www/example.com',
    directory_allow_override => 'All',
}