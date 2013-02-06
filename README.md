## Dcm4chee

[![Build Status](https://travis-ci.org/menglifang/dcm4chee.png?branch=develop)](https://travis-ci.org/menglifang/dcm4chee)
[![Dependency Status](https://gemnasium.com/menglifang/dcm4chee.png)](https://gemnasium.com/menglifang/dcm4chee)
[![Code Climate](https://codeclimate.com/github/menglifang/dcm4chee/badges)](https://codeclimate.com/github/menglifang/dcm4chee/badges)

dcm4chee is a [rails
engine](http://api.rubyonrails.org/classes/Rails/Engine.html) 
which provides RESTful APIs for the most famous
[dcm4chee](http://www.dcm4che.org).

### Installation

The engine interfaces with the dcm4chee archive through Jolokia (http://www.jolokia.org/), which provides a JMX interface with JSON over HTTP. To install Jolokia, simply download the .war and drop it in your archive's /server/default/deploy directory.

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
