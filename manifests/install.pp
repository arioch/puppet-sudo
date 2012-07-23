# Class: sudo::install
#
#
class sudo::install {
  package { $sudo::pkg_name:
    ensure => $sudo::pkg_ensure;
  }
}

