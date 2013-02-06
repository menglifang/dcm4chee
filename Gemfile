source 'https://rubygems.org'

# Declare your gem's dependencies in dcm4chee.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem 'jquery-rails'
gem 'dm-rails'

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

group :development, :test do
  gem 'yard'
  gem 'kramdown'
  gem 'pry'
  gem 'rspec-rails'
  gem 'konacha'
  # For development
  gem 'dm-sqlite-adapter'
  # Connect to the database of dcm4chee server
  gem 'dm-mysql-adapter'
end

group :test do
  gem 'ffaker'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'shoulda-matchers'
  gem 'json_spec'
  gem 'fivemat'
end
