$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dcm4chee/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dcm4chee"
  s.version     = Dcm4chee::VERSION
  s.authors     = ["Tower He"]
  s.email       = ["towerhe@gmail.com"]
  s.homepage    = "https://github.com/menglifang/dcm4chee"
  s.summary     = "Providing RESTful APIs for dcm4chee."
  s.description = "Providing RESTful APIs for dcm4chee."

  s.files = Dir["{app,config,lib}/**/*"] + ["Rakefile", "README.md"]
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 3.2.11"
  s.add_dependency "confstruct", "~> 0.2.3"
  s.add_dependency "virtus", "~> 0.5.4"
  s.add_dependency "dicom", "~> 0.9.3"
  s.add_dependency "sys-filesystem", "~> 1.1"
  s.add_dependency "hex_string", "~> 1.0.0"
  s.add_dependency "dm-searcher", "~> 0.1.3"
  s.add_dependency "dm-pager", "~> 1.1.0"
  s.add_dependency "jolokia", "~> 0.1.0"
end
