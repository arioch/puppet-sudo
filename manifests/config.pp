# Class: sudo::config
#
#
class sudo::config {
  File {
    owner => $sudo::config_user,
    group => $sudo::config_group,
  }

  file {
    $sudo::config_dir:
      ensure => directory,
      mode   => '0755';

    $sudo::config_main:
      ensure  => present,
      mode    => '0440',
      content => template('sudo/sudoers.erb');

    $sudo::binary:
      ensure => file,
      mode   => '4755';
  }
}

