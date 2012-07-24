require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe "sudo::group" do

  let(:node) { 'sudo' }
  let(:facts) { {:operatingsystem => 'Debian'} }
  let(:pre_condition) {
    "class { 'sudo':; }"
  }

  let(:title) { 'group1' }
  let(:params) {
    {
      :ensure => 'present'
    }
  }

  it do
    should create_sudo__group('group1')
    should contain_file('/etc/sudoers.d/group_group1').with_mode('0440')
    should contain_file('/etc/sudoers.d/group_group1').with_ensure('present')
  end
end

