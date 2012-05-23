# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chili/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jens Balvig"]
  gem.email         = ["jens@balvig.com"]
  gem.description   = %q{The spicy extension framework (work in progress)}
  gem.summary       = %q{The spicy extension framework (work in progress)}
  gem.homepage      = "https://github.com/balvig/chili"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "chili"
  gem.require_paths = ["lib"]
  gem.version       = Chili::VERSION

  gem.add_dependency "rails", "~> 3.1"
  gem.add_development_dependency 'rspec', '~> 2.9.0'
  gem.add_development_dependency 'rspec-rails', '~> 2.9.0'
  gem.add_development_dependency 'jquery-rails'
  gem.add_development_dependency 'capybara'
  gem.add_development_dependency "sqlite3"
end
