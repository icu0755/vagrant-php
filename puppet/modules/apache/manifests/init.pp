class apache (
    $config_dir = '/etc/apache2',
    $data_dir = '/var/www',
    $log_dir = '/var/log/apache2',
    $config_file_mode = '0644',
    $config_file_owner = 'root',
    $config_file_group = 'root',
    $manage_service_autorestart = 'Service[apache]',
    $package = 'apache2',
    $service = 'apache2',
    ) {
    $vdir = "${apache::config_dir}/sites-available"
    
    package { 'apache':
        ensure => latest,
        name => $apache::package,
        require => Class['apt'],
    }

    service { 'apache':
        name => $apache::service,
        enable  => true,
        ensure  => running,
        require => Package["apache"];
    }
}