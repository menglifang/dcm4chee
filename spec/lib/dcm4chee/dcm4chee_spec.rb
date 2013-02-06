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

  describe '.respond_to?' do
    context 'when the service is defined' do
      class Dcm4chee::Service::MyService < Dcm4chee::Service::MBean; end

      it 'responds to a service method' do
        expect(Dcm4chee).to be_respond_to :my_service
      end
    end

    context 'when the service is not defined' do
      it 'does not respond to a service method' do
        expect(Dcm4chee).not_to be_respond_to :not_exist_service
      end
    end
  end

  describe '.method_missing' do
    class Dcm4chee::Service::SimpleService < Dcm4chee::Service::MBean; end

    it 'creates a dynamic method for Dcm4chee::Service' do
      expect(Dcm4chee.simple_service).to be_a Dcm4chee::Service::SimpleService
    end
  end
end
