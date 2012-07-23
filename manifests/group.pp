# Define: sudo::group
# Parameters: ensure, $sudo_alias, sudo_auth, $sudo_cmd
#
define sudo::group (
  $ensure,
  $sudo_alias = 'ALL',
  $sudo_auth  = '(ALL)',
  $sudo_cmd   = 'ALL'
) {
  # %wheel ALL = (ALL) ALL
  # %wheel ALL = NOPASSWD: ALL

  case $ensure {
    /present/: {
      file { "${sudo::config_dir}/group_${name}":
        ensure  => file,
        mode    => '0440',
        content => "%${name} ${sudo_alias} = ${sudo_auth} ${sudo_cmd}";
      }
    }

    /absent|removed/: {
      file { "${sudo::config_dir}/group_${name}":
        ensure  => absent;
      }
    }

    default: {
      fail 'No value for ensure found.'
    }
  }
}

