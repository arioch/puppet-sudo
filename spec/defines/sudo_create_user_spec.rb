require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe "sudo::user" do

  let(:node) { 'sudo' }
  let(:facts) { {:operatingsystem => 'Debian', :kernel => 'Linux'} }
  let(:pre_condition) {
    "class { 'sudo':; }"
  }

  let(:title) { 'user1' }
  let(:params) {
    {
      :ensure => 'present'
    }
  }

  it do
    should create_sudo__user('user1')
    should contain_file('/etc/sudoers.d/user_user1').with_ensure('present')
    should contain_file('/etc/sudoers.d/user_user1').with_mode('0440')
  end
end

