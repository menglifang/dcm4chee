require 'spec_helper'

describe Dcm4chee do
  describe '.configure' do
    before(:each) do
      Dcm4chee.configure do
        jolokia_url 'http://localhost:8080/jolokia'

        repository do
          adapter 'sqlite3'
          database './db/dcm4chee.sqlite3'
        end
      end
    end

    after(:each) do
      Dcm4chee.instance_variable_set(:@config, nil)
    end

    subject { Dcm4chee.config }

    its(:jolokia_url) { should == 'http://localhost:8080/jolokia' }

    it 'sets the adapter of the repository' do
      expect(subject.repository.adapter).to eql('sqlite3')
    end

    it 'sets the database of the repository' do
      expect(subject.repository.database).to eql('./db/dcm4chee.sqlite3')
    end
  end
end
