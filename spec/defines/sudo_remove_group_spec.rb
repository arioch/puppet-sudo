require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe "sudo::group" do

  let(:node) { 'sudo' }
  let(:facts) { {:operatingsystem => 'Debian', :kernel => 'Linux'} }
  let(:pre_condition) {
    "class { 'sudo':; }"
  }

  let(:title) { 'group2' }
  let(:params) {
    {
      :ensure => 'absent'
    }
  }

  it do
    should create_sudo__group('group2')
    should contain_file('/etc/sudoers.d/group_group2').with_ensure('absent')
  end
end

