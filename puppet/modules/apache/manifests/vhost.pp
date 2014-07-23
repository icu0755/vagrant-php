define apache::vhost (
  $server_admin                 = '',
  $server_name                  = '',
  $docroot                      = '',
  $docroot_create               = false,
  $docroot_owner                = 'root',
  $docroot_group                = 'root',
  $port                         = '80',
  $ip_addr                      = '*',
  $ssl                          = false,
  $template                     = 'apache/virtualhost/vhost.conf.erb',
  $source                       = '',
  $priority                     = '50',
  $serveraliases                = '',
  $env_variables                = '',
  $enable                       = true,
  $directory                    = '',
  $directory_options            = '',
  $directory_allow_override     = 'None',
  $directory_require            = '',
  $aliases                      = ''
) {

  $ensure = $enable ? {
        true => present,
        false => present,
        absent => absent,
  }
  $bool_docroot_create               = $docroot_create

  $real_docroot = $docroot ? {
    ''      => "${apache::data_dir}/${name}",
    default => $docroot,
  }

  $real_directory = $directory ? {
    ''      => $apache::data_dir,
    default => $directory,
  }

  $server_name_value = $server_name ? {
    ''      => $name,
    default => $server_name,
  }

  $manage_file_source = $source ? {
    ''      => undef,
    default => $source,
  }

  # Server admin email
  if $server_admin != '' {
    $server_admin_email = $server_admin
  } elsif ($name != 'default') and ($name != 'default-ssl') {
    $server_admin_email = "webmaster@${name}"
  } else {
    $server_admin_email = 'webmaster@localhost'
  }

  # Config file path
  $config_file_path = "${apache::vdir}/${name}.conf"

  # Config file enable path
  $config_file_enable_path = "${apache::config_dir}/sites-enabled/${name}.conf"

  $manage_file_content = $template ? {
    ''      => undef,
    undef   => undef,
    default => template($template),
  }

  include apache

  file { $config_file_path:
    ensure  => $ensure,
    source  => $manage_file_source,
    content => $manage_file_content,
    mode    => $apache::config_file_mode,
    owner   => $apache::config_file_owner,
    group   => $apache::config_file_group,
    require => Package['apache'],
    notify  => $apache::manage_service_autorestart,
  }

  # Some OS specific settings:
  # On Debian/Ubuntu manages sites-enabled
  $file_vhost_link_ensure = $enable ? {
    true    => $config_file_path,
    false   => absent,
    absent  => absent,
  }
  file { "ApacheVHostEnabled_${name}":
    ensure  => $file_vhost_link_ensure,
    path    => $config_file_enable_path,
    require => Package['apache'],
    notify  => $apache::manage_service_autorestart,
  }

  if $bool_docroot_create == true {
    file { $real_docroot:
      ensure  => directory,
      owner   => $docroot_owner,
      group   => $docroot_group,
      mode    => '0775',
      require => Package['apache'],
    }
  }

  if $bool_passenger == true {
    include apache::passenger
  }
}
