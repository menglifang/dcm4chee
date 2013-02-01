require 'spec_helper'

describe 'Creating application entities', type: :request do
  context 'with valid attributes' do
    it 'creates an application entity' do
      begin
        post '/dcm4chee/api/application_entities', format: :json,
          application_entity: {
            title: 'CDRecorder',
            host: '192.168.1.250',
            port: '1234'
          }
      rescue
        pending 'You should deploy a dcm4chee server with jolokia at http://localhost:8080/jolokia. see spec_helper.rb'
      end

      response.status.should == 201
    end
  end
end
