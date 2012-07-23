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
      file { "${sudo::config_dir}/user_${name}":
        ensure  => file,
        mode    => '0440',
        content => "${name} ${sudo_alias} = ${sudo_auth} ${sudo_cmd}";
      }
    }

    /absent|removed/: {
      file { "${sudo::config_dir}/user_${name}":
        ensure  => absent;
      }
    }

    default: { fail 'No value for ensure found.'}
  }
}

