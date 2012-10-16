$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "another_blank_extension/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "another_blank_extension"
  s.version     = AnotherBlankExtension::VERSION
  s.authors     = ["Jens Balvig"]
  s.email       = ["jens@cookpad.com"]
  s.homepage    = ""
  s.summary     = "Summary of AnotherBlankExtension."
  s.description = "Description of AnotherBlankExtension."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency 'chili', '~> 1.0'

  s.add_development_dependency "sqlite3"
end
