require 'spec_helper'

describe Dcm4chee do
  describe '.configure' do
    before(:all) do
      @config = Dcm4chee.config.clone

      Dcm4chee.configure do
        jolokia_url 'http://localhost:8080/jolokia'

        repo do
          adapter 'sqlite3'
          database './db/dcm4chee.sqlite3'
        end
      end
    end

    after(:all) do
      Dcm4chee.instance_variable_set(:'@config', @config)
    end

    subject { Dcm4chee.config }

    its(:jolokia_url) { should == 'http://localhost:8080/jolokia' }

    it 'sets the adapter of the repository' do
      expect(subject.repo.adapter).to eql('sqlite3')
    end

    it 'sets the database of the repository' do
      expect(subject.repo.database).to eql('./db/dcm4chee.sqlite3')
    end
  end
end
