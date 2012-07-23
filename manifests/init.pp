# Class: sudo
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
class sudo (
  $binary       = $sudo::params::binary,
  $config_dir   = $sudo::params::config_dir,
  $config_group = $sudo::params::config_group,
  $config_main  = $sudo::params::config_main,
  $config_user  = $sudo::params::config_user,
  $pkg_ensure   = $sudo::params::pkg_ensure,
  $pkg_name     = $sudo::params::pkg_name,
) inherits sudo::params {

  include sudo::install
  include sudo::config

  Class['sudo::install'] ->
  Class['sudo::config']

}

