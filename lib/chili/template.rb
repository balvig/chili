# Edit gemspec
require File.expand_path('../version', __FILE__)
gemspec = "#{name}.gemspec"
gsub_file gemspec, '# s.add_dependency "jquery-rails"', "s.add_dependency 'chili', '~> #{Chili::VERSION}'"
gsub_file gemspec, 'TODO: Your name', `git config user.name`.chomp
gsub_file gemspec, 'TODO: Your email', `git config user.email`.chomp
gsub_file gemspec, /TODO(:\s)?/, ''
gsub_file gemspec, 'Dir["test/**/*"]', 's.files.grep(%r{^(test|spec|features)/})'

# Add gem to main app Gemfile
append_to_file "../../Gemfile", "gem '#{name}', path: '#{app_path}'"

# Uses Chili::ApplicationController and the layout from the main app
remove_dir "app/controllers/#{name}"
remove_dir "app/helpers/#{name}"
remove_dir 'app/views/layouts'

# Uses Gemfile from main app
remove_file 'Gemfile'

# Replace Rakefile
remove_file 'Rakefile'

# Remove jquery stuff from application.js
gsub_file "app/assets/javascripts/#{name}/application.js", "//= require jquery_ujs\n", ''
gsub_file "app/assets/javascripts/#{name}/application.js", "//= require jquery\n", ''

# Setup custom generator
inject_into_file "lib/#{name}/engine.rb", after: "isolate_namespace #{name.camelcase}\n" do <<-RUBY
    config.generators do |g|
      g.scaffold_controller :chili
    end
RUBY
end

# Remove dummy stuff
remove_dir 'test'

inject_into_file "lib/#{name}/engine.rb", :after => " g.scaffold_controller :chili\n" do <<-RUBY
      g.test_framework :rspec, view_specs: false, routing_specs: false, controller_specs: false
      g.integration_tool :rspec
RUBY
end

# Edit .gitignore
gsub_file ".gitignore", /test\/dummy.*\n/, ''

# Automount engine
prepend_to_file 'config/routes.rb', "#{name.camelcase}::Engine.automount!\n"

# Include chili libs
prepend_to_file "lib/#{name}.rb" do <<-RUBY
require "chili"
RUBY
end


# Include active_if
inject_into_file "lib/#{name}.rb", :after => "module #{name.camelcase}\n" do <<-RUBY
  extend Chili::Activatable
  active_if { logged_in? }
RUBY
end

# Add dummy override
example_file_path = "app/overrides/layouts/application/example.html.erb.deface"
create_file example_file_path do <<-RUBY
<!-- insert_bottom 'body' -->
<div style='background: #FFF;text-align: center; padding: 4px 0;position: fixed;width: 100%;z-index: 9999;top: 0;'>
  #{name} active - edit/remove this file:<br/>
  <strong>#{app_path}/#{example_file_path}</strong><br/>
  <%= link_to 'deface docs', 'https://github.com/railsdog/deface', target: '_blank' %>
</div>
RUBY
end

# Disable bundler
def run_bundle ; end
