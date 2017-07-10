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
  s.summary     = "Voyager Course Module Lesson System"
  s.description = "A partial backend to a course system. Hacky at best, not currently maintained."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.post_install_message = "VOYAGER: RUN - rails voyager:install:migrations\nVOYAGER: CHECK - routes.rb"

  s.add_dependency "rails", "~> 5.0.1"
end
