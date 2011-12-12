# Class: sudo::install
#
#
class sudo::install {
  Package {
    require => [
      Class['sudo::params'],
    ],
  }

  package {
    $sudo::params::pkg:
      ensure => installed;
  }
}
