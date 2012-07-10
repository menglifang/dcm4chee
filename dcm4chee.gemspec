$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dcm4chee/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dcm4chee"
  s.version     = Dcm4chee::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Dcm4chee."
  s.description = "TODO: Description of Dcm4chee."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.6"
end
