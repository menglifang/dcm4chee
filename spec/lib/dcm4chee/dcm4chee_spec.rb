require 'spec_helper'

describe Dcm4chee do
  describe '.configure' do
    before(:all) do
      @config = Dcm4chee.config.clone

      Dcm4chee.configure do
        jolokia_url     'http://localhost:8080/jolokia'

        repository_name :dcm4chee
        repository_uri  'sqlite::memory:'
      end
    end

    after(:all) do
      Dcm4chee.instance_variable_set(:'@config', @config)
    end

    subject { Dcm4chee.config }

    its(:jolokia_url) { should == 'http://localhost:8080/jolokia' }
    its(:repository_name) { should == :dcm4chee }
    its(:repository_uri) { should == 'sqlite::memory:' }
  end
end
