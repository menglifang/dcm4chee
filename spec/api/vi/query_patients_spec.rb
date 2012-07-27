require 'spec_helper'

describe 'Querying patients', type: :request do
  before do
    create(:patient, name: 'Hello Kitty')
    create(:patient, name: 'Hello Snoopy')
  end

  context 'by name' do
    context 'exactly' do
      it 'responses patients named Hello Kitty' do
        get '/dcm4chee/api/patients', format: :json, q: { name: 'Hello Kitty' }

        response.status.should == 200

        json = response.body
        json.should have_json_size(1).at_path('patients')
        json.should be_json_eql(%("Hello Kitty")).at_path('patients/0/name')
        json.should be_json_eql(%(1)).at_path('total')
      end
    end

    context 'fuzzily' do
      it 'responses patients which first name are Hello' do
        get '/dcm4chee/api/patients', format: :json, q: { 'name.like' => 'Hello%' }

        response.status.should == 200

        json = response.body
        json.should have_json_size(2).at_path('patients')
        json.should be_json_eql(%("Hello Snoopy")).at_path('patients/0/name')
        json.should be_json_eql(%("Hello Kitty")).at_path('patients/1/name')
        json.should be_json_eql(%(2)).at_path('total')
      end
    end
  end
end
