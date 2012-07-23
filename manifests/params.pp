# Class sudo::params
#
#
class sudo::params {
  $config_dir   = '/etc/sudoers.d'
  $config_group = 'root'
  $config_main  = '/etc/sudoers'
  $config_user  = 'root'
  $pkg_ensure   = 'present'
  $pkg_name     = 'sudo'

  case $::operatingsystem {
    'Debian', 'Ubuntu': {
      $binary  = '/usr/bin/sudo'
    }

    'RedHat', 'CentOS': {
      $binary  = '/usr/bin/sudo'
    }

    default: {
      fail "Operating system ${::operatingsystem} is not supported."
    }
  }
}

