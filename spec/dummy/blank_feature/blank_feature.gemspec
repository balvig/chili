$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blank_feature/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blank_feature"
  s.version     = BlankFeature::VERSION
  s.authors     = ["GIT_AUTHOR"]
  s.email       = ["GIT_EMAIL"]
  s.homepage    = ""
  s.summary     = "Summary of BlankFeature."
  s.description = "Description of BlankFeature."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.9"
  s.add_dependency 'chili', '~> 2.0'

  s.add_development_dependency "sqlite3"
end
