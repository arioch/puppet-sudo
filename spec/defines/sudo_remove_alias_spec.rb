require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe "sudo::alias" do

  let(:node) { 'sudo' }
  let(:facts) { {:operatingsystem => 'Debian', :kernel => 'Linux'} }
  let(:pre_condition) {
    "class { 'sudo':; }"
  }

  let(:title) { 'alias2' }
  let(:params) {
    {
      :ensure => 'absent'
    }
  }

  it do
    should create_sudo__alias('alias2')
    should contain_file('/etc/sudoers.d/alias_alias2').with_ensure('absent')
  end
end

