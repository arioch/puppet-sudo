# Class: sudo::config
#
#
class sudo::config {
  File {
    owner => $sudo::params::user,
    group => $sudo::params::group,
  }

  file {
    $sudo::params::confdir:
      ensure => directory,
      mode   => '0750';

    $sudo::params::config:
      ensure  => present,
      mode    => '0440',
      content => template ('sudo/sudoers.erb');

    $sudo::params::binary:
      ensure => file,
      mode   => '4755';
  }
}
