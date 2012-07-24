require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe "sudo::group" do

  let(:node) { 'sudo' }
  let(:facts) { {:operatingsystem => 'Debian'} }
  let(:pre_condition) {
    "class { 'sudo':; }"
  }

  let(:title) { 'somealias' }
  let(:params) {
    {
      :ensure     => 'present',
      :sudo_alias => 'newalias'
    }
  }

  it do
    should create_sudo__group('somealias')
    should contain_file('/etc/sudoers.d/group_somealias').with_mode('0440')
    should contain_file('/etc/sudoers.d/group_somealias').with_content(/newalias/)
  end
end

