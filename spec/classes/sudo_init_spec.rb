require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'sudo' do
  let(:title) { 'sudo' }
  let(:node)  { 'sudo' }

  rpm_distros = [ 'RedHat', 'CentOS', 'Scientific', 'OEL', 'Amazon' ]
  deb_distros = [ 'Debian', 'Ubuntu' ]
  all_distros = rpm_distros | deb_distros


  ##############################################################################
  #
  # RPM-based distros
  #

  rpm_distros.each do |os|
  end


  ##############################################################################
  #
  # Debian-based distros
  #

  deb_distros.each do |os|
  end


  ##############################################################################
  #
  # Both RPM and Debian-based distros
  #

  all_distros.each do |os|
    describe "#{os}, without parameters" do
      let(:facts) do
        {
          'operatingsystem' => os
        }
      end

      it do
        should include_class('sudo::install')
        should include_class('sudo::config')
        should contain_file('/etc/sudoers')
        should_not raise_error(Puppet::ParseError)
      end
    end

    describe "#{os}, with parameter binary" do
      let(:facts) do
        {
          'operatingsystem' => os
        }
      end

      let(:params) do
        {
          :binary => '/usr/local/bin/sudo',
        }
      end

      it do
        should include_class('sudo::install')
        should include_class('sudo::config')
        should contain_file('/etc/sudoers')
        should_not raise_error(Puppet::ParseError)
      end
    end

    describe "#{os}, with parameter config dirs" do
      let(:facts) do
        {
          'operatingsystem' => os
        }
      end

      let(:params) do
        {
          :config_main  => '/usr/local/sudo',
          :config_dir   => '/usr/local/sudo/etc',
          :config_user  => 'sudo-user',
          :config_group => 'sudo-group',
        }
      end

      it do
        should contain_file('/usr/local/sudo').with_owner('sudo-user')
        should contain_file('/usr/local/sudo').with_group('sudo-group')
        should contain_file('/usr/local/sudo/etc').with_owner('sudo-user')
        should contain_file('/usr/local/sudo/etc').with_group('sudo-group')
        should_not raise_error(Puppet::ParseError)
      end
    end

    describe "#{os}, with parameter config dirs" do
      let(:facts) do
        {
          'operatingsystem' => os
        }
      end

      let(:params) do
        {
          :pkg_ensure => 'latest',
          :pkg_name   => 'sudo-pkg',
        }
      end

      it do
        should contain_package('sudo-pkg').with_ensure('latest')
        should_not raise_error(Puppet::ParseError)
      end
    end
  end
end

