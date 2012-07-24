require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe "sudo::user" do

  let(:node) { 'sudo' }
  let(:facts) { {:operatingsystem => 'Debian'} }
  let(:pre_condition) {
    "class { 'sudo':; }"
  }

  let(:title) { 'testcmd' }
  let(:params) {
    {
      :ensure     => 'present',
      :sudo_alias => 'somecmd'
    }
  }

  it do
    should create_sudo__user('testcmd')
    should contain_file('/etc/sudoers.d/user_testcmd').with_mode('0440')
    should contain_file('/etc/sudoers.d/user_testcmd').with_content(/somecmd/)
  end
end

