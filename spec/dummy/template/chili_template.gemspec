$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chili_template/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chili_template"
  s.version     = ChiliTemplate::VERSION
  s.authors     = ["Jens Balvig"]
  s.email       = ["jens@cookpad.com"]
  s.homepage    = ""
  s.summary     = "Summary of ChiliTemplate."
  s.description = "Description of ChiliTemplate."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency "rails", "~> 3.2.3"
  s.add_dependency 'chili', '~> 0.2.2'

  s.add_development_dependency "sqlite3"
end
