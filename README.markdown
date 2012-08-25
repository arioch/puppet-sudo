## Sample Usage:

    sudo::user {
      'foobar':
        ensure      => present,
        # sudo_auth => 'NOPASSWD:';  # default: (ALL)
    }

    sudo::group {
      'wheel':
        ensure      => present;
        # sudo_auth => 'NOPASSWD:';  # default: (ALL)
    }

    sudo::alias {
      'ADMINS':
        ensure          => present,
        sudo_alias_type => 'User_Alias',
        sudo_alias      => 'jsmith, mikem';

      'FILESERVERS':
        ensure          => present,
        sudo_alias_type => 'Host_Alias',
        sudo_alias      => 'fs1, fs2';

      'SERVICES':
        ensure          => present,
        sudo_alias_type => 'Cmnd_Alias',
        sudo_alias      => '/sbin/service, /sbin/chkconfig';
    }

