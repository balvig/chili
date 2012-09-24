$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blank_extension/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blank_extension"
  s.version     = BlankExtension::VERSION
  s.authors     = ["GIT_AUTHOR"]
  s.email       = ["GIT_EMAIL"]
  s.homepage    = ""
  s.summary     = "Summary of BlankExtension."
  s.description = "Description of BlankExtension."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency 'chili', '~> 0.3.4'

  s.add_development_dependency "sqlite3"
end
