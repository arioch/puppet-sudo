require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe "sudo::group" do

  let(:node) { 'sudo' }
  let(:facts) { {:operatingsystem => 'Debian'} }
  let(:pre_condition) {
    "class { 'sudo':; }"
  }

  let(:title) { 'authtest' }
  let(:params) {
    {
      :ensure     => 'present',
      :sudo_alias => 'authnew'
    }
  }

  it do
    should create_sudo__group('authtest')
    should contain_file('/etc/sudoers.d/group_authtest').with_mode('0440')
    should contain_file('/etc/sudoers.d/group_authtest').with_content(/authnew/)
  end
end

