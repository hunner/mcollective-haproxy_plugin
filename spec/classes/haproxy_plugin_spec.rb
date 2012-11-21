require 'spec_helper'

describe 'haproxy_plugin', :type => :class do
  context "for PE" do
    let :facts do
      { :puppetversion => '2.7.19 (Puppet Enterprise 2.6.1)' }
    end
    describe "an haproxy node" do
      it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/application/haproxy.rb") }
      it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/haproxy.ddl") }
      it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/haproxy.rb").with(
        'ensure' => 'present',
      ) }
    end
    describe "a non-haproxy (default) node" do
      let :params do
        { :agent => false }
      end
      it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/application/haproxy.rb") }
      it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/haproxy.ddl") }
      it { should contain_file("/opt/puppet/libexec/mcollective/mcollective/agent/haproxy.rb").with(
        'ensure' => 'absent',
      ) }
    end
  end
  context "for POSS" do
    let :facts do
      { :puppetversion => '2.7.19' }
    end
    describe "an haproxy node" do
      it { should contain_file("/usr/libexec/mcollective/mcollective/application/haproxy.rb") }
      it { should contain_file("/usr/libexec/mcollective/mcollective/agent/haproxy.ddl") }
      it { should contain_file("/usr/libexec/mcollective/mcollective/agent/haproxy.rb").with(
        'ensure' => 'present',
      ) }
    end
    describe "a non-haproxy (default) node" do
      let :params do
        { :agent => false }
      end
      it { should contain_file("/usr/libexec/mcollective/mcollective/application/haproxy.rb") }
      it { should contain_file("/usr/libexec/mcollective/mcollective/agent/haproxy.ddl") }
      it { should contain_file("/usr/libexec/mcollective/mcollective/agent/haproxy.rb").with(
        'ensure' => 'absent',
      ) }
    end
  end
end
