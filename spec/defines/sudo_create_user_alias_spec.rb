require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe "sudo::user" do

  let(:node) { 'sudo' }
  let(:facts) { {:operatingsystem => 'Debian'} }
  let(:pre_condition) {
    "class { 'sudo':; }"
  }

  let(:title) { 'somealias' }
  let(:params) {
    {
      :ensure     => 'present',
      :sudo_alias => 'somealias'
    }
  }

  it do
    should create_sudo__user('somealias')
    should contain_file('/etc/sudoers.d/user_somealias').with_mode('0440')
    should contain_file('/etc/sudoers.d/user_somealias').with_content(/somealias/)
  end
end

