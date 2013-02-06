# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.join(File.dirname(__FILE__), 'dummy/config/environment')
require 'rspec/rails'
require 'rspec/autorun'

require 'factory_girl_rails'
require 'pry'
require 'ffaker'
require 'json_spec'

require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-webkit'

require 'dcm4chee'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('support/**/*.rb')].each {|f| require f}

DataMapper.setup(:default, 'sqlite::memory:')

Dcm4chee.configure do
  server_home '/home/tower/Apps/dcm4chee-2.17.2-psql'
  jolokia_url 'http://localhost:8080/jolokia'

  repository_name :dcm4chee
  repository_uri 'sqlite::memory:'
end

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.include FactoryGirl::Syntax::Methods

  config.before(:each) { DataMapper.auto_migrate! }
end
