require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe "sudo::alias" do

  let(:node) { 'sudo' }
  let(:facts) { {:operatingsystem => 'Debian'} }
  let(:pre_condition) {
    "class { 'sudo':; }"
  }

  let(:title) { 'somealias' }
  let(:params) {
    {
      :ensure          => 'present',
      :sudo_alias_type => 'Host_Alias',
      :sudo_alias      => 'newalias',
    }
  }

  it do
    should create_sudo__alias('somealias')
    should contain_file('/etc/sudoers.d/alias_host_somealias').with_mode('0440')
    should contain_file('/etc/sudoers.d/alias_host_somealias').with_content(/Host_Alias/)
    should contain_file('/etc/sudoers.d/alias_host_somealias').with_content(/somealias/)
    should contain_file('/etc/sudoers.d/alias_host_somealias').with_content(/newalias/)
  end
end

