$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "browet/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "browet"
  s.version     = Browet::VERSION
  s.authors     = ["WebiumDigital"]
  s.email       = ["w@webium.digital"]
  s.homepage    = "https://github.com/WebiumDigital/browet-rails"
  s.summary     = "Rails plugin for http://browet.com."
  s.description = "Rails plugin for http://browet.com."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "json"
  s.add_development_dependency "rspec"
  s.add_development_dependency "webmock"
  s.add_development_dependency "pg"
end
