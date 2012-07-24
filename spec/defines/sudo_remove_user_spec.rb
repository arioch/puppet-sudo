require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe "sudo::user" do

  let(:node) { 'sudo' }
  let(:facts) { {:operatingsystem => 'Debian', :kernel => 'Linux'} }
  let(:pre_condition) {
    "class { 'sudo':; }"
  }

  let(:title) { 'user2' }
  let(:params) {
    {
      :ensure => 'absent'
    }
  }

  it do
    should create_sudo__user('user2')
    should contain_file('/etc/sudoers.d/user_user2').with_ensure('absent')
  end
end

