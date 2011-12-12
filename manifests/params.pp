# Class sudo::params
#
#
class sudo::params {
  $user    = 'root'
  $group   = 'root'
  $pkg     = 'sudo'
  $confdir = '/etc/sudoers.d'
  $config  = '/etc/sudoers'

  case $::operatingsystem {
    'debian', 'ubuntu': {
      $binary  = '/usr/bin/sudo'
    }

    'RedHat', 'CentOS': {
      $binary  = '/usr/bin/sudo'
    }

    default: {
      fail 'Operating system not supported yet.'
    }
  }
}
