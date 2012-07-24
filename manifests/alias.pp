# Define: sudo::alias
# Parameters: ensure, sudo_alias_type, sudo_alias
#
define sudo::alias (
  $ensure,
  $sudo_alias_type = undef,
  $sudo_alias      = undef
) {
  # User_Alias     ADMINS = jsmith, mikem
  # Host_Alias     FILESERVERS = fs1, fs2
  # Cmnd_Alias     SERVICES = /sbin/service, /sbin/chkconfig

  case $ensure {
    /present/: {
      if ! $sudo_alias {
        fail 'Sudo alias value is not defined.'
      }

      case $sudo_alias_type {
        'User_Alias': {
          file { "${sudo::config_dir}/alias_user_${name}":
            ensure  => present,
            mode    => '0440',
            content => "${sudo_alias_type} ${name} = ${sudo_alias}";
          }
        }

        'Host_Alias': {
          file { "${sudo::config_dir}/alias_host_${name}":
            ensure  => present,
            mode    => '0440',
            content => "${sudo_alias_type} ${name} = ${sudo_alias}";
          }
        }

        'Cmnd_Alias': {
          file { "${sudo::config_dir}/alias_cmnd_${name}":
            ensure  => file,
            mode    => '0440',
            content => "${sudo_alias_type} ${name} = ${sudo_alias}";
          }
        }

        default: {
          fail 'Alias type not supported. Valid options: User_Alias, Host_Alias, Cmnd_Alias.'
        }
      }
    }

    /absent|removed/: {
      file { "${sudo::config_dir}/alias_${name}":
        ensure => absent;
      }
    }
  }
}

