$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chili_invites/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chili_invites"
  s.version     = ChiliInvites::VERSION
  s.authors     = ["Jens Balvig"]
  s.email       = ["jens@cookpad.com"]
  s.homepage    = ""
  s.summary     = "Summary of ChiliInvites."
  s.description = "Description of ChiliInvites."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.6"
  s.add_dependency 'chili', '~> 0.3.0'

  s.add_development_dependency "sqlite3"
end
