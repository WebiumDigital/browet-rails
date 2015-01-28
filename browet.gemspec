$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "browet/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "browet"
  s.version     = Browet::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Browet."
  s.description = "TODO: Description of Browet."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
end
