## Dcm4chee

dcm4chee is a [rails
engine](http://api.rubyonrails.org/classes/Rails/Engine.html) 
which provides RESTful APIs for the most famous
[dcm4chee](http://www.dcm4che.org).

### Installation

Add the dcm4chee to your Gemfile.

```ruby
gem 'dcm4chee'
```

And then, run `bundle install` to install. That's it.

### Development

#### Check the docs

```bash
# Generated the docs
yardoc

# Start a web server for serving the docs
yard server

# Visit http://localhost:8808
```

#### Tests

```bash
bundle exec rspec

# Or
bundle exec rake spec
```
