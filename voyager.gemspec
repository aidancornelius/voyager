$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "voyager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "voyager"
  s.version     = Voyager::VERSION
  s.authors     = ["Aidan Cornelius-Bell"]
  s.email       = ["aidan@teachersolutions.com.au"]
  s.homepage    = "https://www.teachersolutions.com.au"
  s.summary     = "Summary of Voyager."
  s.description = "Description of Voyager."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"
end
