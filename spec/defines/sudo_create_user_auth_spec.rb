require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe "sudo::user" do

  let(:node) { 'sudo' }
  let(:facts) { {:operatingsystem => 'Debian'} }
  let(:pre_condition) {
    "class { 'sudo':; }"
  }

  let(:title) { 'authtest' }
  let(:params) {
    {
      :ensure     => 'present',
      :sudo_alias => 'authtest'
    }
  }

  it do
    should create_sudo__user('authtest')
    should contain_file('/etc/sudoers.d/user_authtest').with_mode('0440')
    should contain_file('/etc/sudoers.d/user_authtest').with_content(/authtest/)
  end
end

