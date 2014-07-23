define apache::mod(
    $ensure = 'present',
    $install_package = false,
) {
    $manage_service_autorestart = 'Service[apache]'
    
    if $install_package != false {
        $modpackage_basename = 'libapache2-mod-'

        $real_install_package = $install_package ? {
          true    => "${modpackage_basename}${name}",
          default => $install_package,
        }

        package { "ApacheModule_${name}":
          ensure  => $ensure,
          name    => $real_install_package,
          notify  => $manage_service_autorestart,
          require => Package['apache'],
        }

      }
    
    case $ensure {
      'present': {

        $exec_a2enmod_subscribe = $install_package ? {
          false   => undef,
          default => Package["ApacheModule_${name}"]
        }
        $exec_a2dismode_before = $install_package ? {
          false   => undef,
          default => Package["ApacheModule_${name}"]
        }

        exec { "/usr/sbin/a2enmod ${name}":
          unless    => "/bin/sh -c '[ -L ${apache::config_dir}/mods-enabled/${name}.load ] && [ ${apache::config_dir}/mods-enabled/${name}.load -ef ${apache::config_dir}/mods-available/${name}.load ]'",
          notify    => $manage_service_autorestart,
          require   => Package['apache'],
          subscribe => $exec_a2enmod_subscribe,
        }
      }
      'absent': {
        exec { "/usr/sbin/a2dismod ${name}":
          onlyif    => "/bin/sh -c '[ -L ${apache::config_dir}/mods-enabled/${name}.load ] && [ ${apache::config_dir}/mods-enabled/${name}.load -ef ${apache::config_dir}/mods-available/${name}.load ]'",
          notify    => $manage_service_autorestart,
          require   => Package['apache'],
          before    => $exec_a2dismode_before,
        }
      }
      default: {
      }
    }
}