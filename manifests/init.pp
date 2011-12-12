# Class: sudonew
#
# This class installs sudo
#
# Parameters:
#
# Actions:
#   - Install sudo
#   - Manage sudo config, user, groups and aliases
#
# Requires:
#
# Sample Usage:
#  sudo::user {
#    'foobar':
#      ensure    => present,
#      #sudo_auth => 'NOPASSWD:'; # default: (ALL)
#
#  sudo::group {
#    'wheel':
#      ensure    => present;
#      #sudo_auth => 'NOPASSWD:';  # default: (ALL)
#  }
#
#  sudo::alias {
#    'ADMINS':
#      ensure          => present,
#      sudo_alias_type => 'User_Alias',
#      sudo_alias      => 'jsmith, mikem';
#
#    'FILESERVERS':
#      ensure          => present,
#      sudo_alias_type => 'Host_Alias',
#      sudo_alias      => 'fs1, fs2';
#
#    'SERVICES':
#      ensure          => present,
#      sudo_alias_type => 'Cmnd_Alias',
#      sudo_alias      => '/sbin/service, /sbin/chkconfig';
#  }
#
# Known limitations:
#
class sudonew {
  class { 'sudo::params': }
  class { 'sudo::install': }
  class { 'sudo::config': }

  Class['sudo::params'] ->
  Class['sudo::install'] ->
  Class['sudo::config']
}

File {
  mode  => '0440',
  owner => $sudo::params::user,
  group => $sudo::params::group,
}

# Define: sudo::user
# Parameters: ensure, sudo_alias, sudo_auth, sudo_cmd
#
define sudo::user (
  $ensure,
  $sudo_alias = 'ALL',
  $sudo_auth  = '(ALL)',
  $sudo_cmd   = 'ALL'
) {
  # root   ALL = (ALL) ALL
  # root   ALL = NOPASSWD: ALL
  case $ensure {
    /present/: {
      file { "${sudo::params::confdir}/user_${name}":
        ensure  => file,
        content => "${name} ${sudo_alias} = ${sudo_auth} ${sudo_cmd}";
      }
    }

    /absent|removed/: {
      file { "${sudo::params::confdir}/user_${name}":
        ensure  => absent;
      }
    }

    default: { fail 'No value for ensure found.'}
  }
}

# Define: sudo::group
# Parameters: ensure, $sudo_alias, sudo_auth, $sudo_cmd
#
define sudo::group (
  $ensure,
  $sudo_alias = 'ALL',
  $sudo_auth  = '(ALL)',
  $sudo_cmd   = 'ALL'
) {
  # %wheel   ALL = (ALL) ALL
  # %wheel   ALL = NOPASSWD: ALL

  case $ensure {
    /present/: {
      file { "${sudo::params::confdir}/group_${name}":
        ensure  => file,
        content => "%${name} ${sudo_alias} = ${sudo_auth} ${sudo_cmd}";
      }
    }

    /absent|removed/: {
      file { "${sudo::params::confdir}/group_${name}":
        ensure  => absent;
      }
    }

    default: { fail 'No value for ensure found.'}
  }
}

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
          file { "${sudo::params::confdir}/alias_user_${name}":
            ensure  => file,
            content => "${alias_type} ${name} = ${sudo_alias_type}";
          }
        }

        'Host_Alias': {
          file { "${sudo::params::confdir}/alias_host_${name}":
            ensure  => file,
            content => "${alias_type} ${name} = ${sudo_alias_type}";
          }
        }

        'Cmnd_Alias': {
          file { "${sudo::params::confdir}/alias_cmnd_${name}":
            ensure  => file,
            content => "${alias_type} ${name} = ${sudo_alias_type}";
          }
        }

        default: {
          fail 'Alias type not supported. Valid options: User_Alias, Host_Alias, Cmnd_Alias.'
        }
      }
    }

    /absent|removed/: {
      file { "${sudo::params::confdir}/alias_${name}":
        ensure  => absent;
      }
    }
  }
}
