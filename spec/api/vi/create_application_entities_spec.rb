require 'spec_helper'

describe 'Creating application entities', type: :request do
  context 'with valid attributes' do
    it 'creates an application entity' do
      post '/dcm4chee/api/application_entities', format: :json,
        application_entity: {
          title: 'CDRecorder',
          host: '192.168.1.250',
          port: '1234'
        }

      response.status.should == 201
    end
  end
end
