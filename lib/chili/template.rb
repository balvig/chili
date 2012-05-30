# Edit gemspec
require File.expand_path('../version', __FILE__)
gemspec = "#{app_path}.gemspec"
gsub_file gemspec, '# s.add_dependency "jquery-rails"', "s.add_dependency 'chili', '~> #{Chili::VERSION}'"
gsub_file gemspec, 'TODO: Your name', `git config user.name`.chomp
gsub_file gemspec, 'TODO: Your email', `git config user.email`.chomp
gsub_file gemspec, /TODO(:\s)?/, ''
gsub_file gemspec, 'Dir["test/**/*"]', 's.files.grep(%r{^(test|spec|features)/})'

# Add main app as submodule
# For some reason root when using git method is test/dummy so doing this manually
main_app_git_repo = ENV['MAIN_APP'] || ask("Where is the main app you are extending located? (ie git://github.com/myname/myapp.git)")
if main_app_git_repo.present?
  run "cd #{destination_root} && git init"
  run "cd #{destination_root} && git submodule add #{main_app_git_repo}  main_app"

  # Add gem to main app Gemfile
  append_to_file "main_app/Gemfile", "gem '#{app_path}', path: '../' # git: '...'"
end


# Uses Chili::ApplicationController and the layout from the main app
remove_dir "app/controllers/#{app_path}"
remove_dir "app/helpers/#{app_path}"
remove_dir 'app/views/layouts'

# Uses Gemfile from main app
remove_file 'Gemfile'

# Replace Rakefile
remove_file 'Rakefile'
create_file 'Rakefile' do <<-RUBY
#!/usr/bin/env rake
APP_RAKEFILE = File.expand_path("../main_app/Rakefile", __FILE__)
require 'chili/tasks'
RUBY
end

# Add Chili commands to rails script
inject_into_file "script/rails","APP_PATH = File.expand_path('../../main_app/config/application',  __FILE__)\n", before: "\nrequire 'rails/all'"
gsub_file "script/rails", 'rails/engine/commands', 'chili/commands'

# Remove jquery stuff from application.js
gsub_file "app/assets/javascripts/#{app_path}/application.js", "//= require jquery_ujs\n", ''
gsub_file "app/assets/javascripts/#{app_path}/application.js", "//= require jquery\n", ''

# Setup custom generator
inject_into_file "lib/#{app_path}/engine.rb", after: "isolate_namespace #{app_path.camelcase}\n" do <<-RUBY
    config.generators do |g|
      g.scaffold_controller :chili
    end
RUBY
end

# Setup rspec
remove_dir 'test'
create_file 'spec/spec_helper.rb' do <<-RUBY
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../main_app/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories in both main app and the extension.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f }
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }
RUBY
end

append_to_file 'Rakefile' do <<-RUBY

# Default rake task to rspec
task default: 'app:spec'
RUBY
end

inject_into_file "lib/#{app_path}/engine.rb", :after => " g.scaffold_controller :chili\n" do <<-RUBY
      g.test_framework :rspec, view_specs: false, routing_specs: false, controller_specs: false
      g.integration_tool :rspec
RUBY
end

# Edit .gitignore
gsub_file ".gitignore", /test\/dummy.*\n/, ''

# Automount engine
prepend_to_file 'config/routes.rb', "#{app_path.camelcase}::Engine.automount!\n"

# Include chili libs
prepend_to_file "lib/#{app_path}.rb" do <<-RUBY
require "chili"
RUBY
end


# Include active_if
inject_into_file "lib/#{app_path}.rb", :after => "module #{app_path.camelcase}\n" do <<-RUBY
  extend Chili::Activatable
  active_if { logged_in? }
RUBY
end

# Add dummy override
example_file_path = "app/overrides/layouts/application/example.html.erb.deface"
create_file example_file_path do <<-RUBY
<!-- insert_bottom 'body' -->
<div style='background: #FFF;text-align: center; padding: 4px 0;position: fixed;width: 100%;z-index: 9999;top: 0;'>
  #{app_path} active - edit/remove this file:<br/>
  <strong>#{example_file_path}</strong><br/>
  <%= link_to 'deface docs', 'https://github.com/railsdog/deface', target: '_blank' %>
</div>
RUBY
end

# Disable bundler
def run_bundle ; end
