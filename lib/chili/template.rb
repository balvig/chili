# Add main app as submodule
# For some reason root when using git method is test/dummy so doing this manually
run "cd #{destination_root} && git init"
run "cd #{destination_root} && git submodule add git@github.com:cookpad/santacruz.git spec/main_app"

# Uses Chili::ApplicationController and the layout from the main app
remove_dir 'app/controllers'
empty_directory 'app/controllers'
remove_dir 'app/views/layouts'

# Add directory for deface overrides
empty_directory 'app/overrides'

# Uses Gemfile from main app
remove_file 'Gemfile'

# Replace Rakefile
remove_file 'Rakefile'
create_file 'Rakefile' do <<-RUBY
#!/usr/bin/env rake
APP_RAKEFILE = File.expand_path("../spec/main_app/Rakefile", __FILE__)
require 'chili/tasks'
RUBY
end

# Setup rspec
remove_dir 'test'
create_file 'spec/spec_helper.rb' do <<-RUBY
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../main_app/config/environment", __FILE__)
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

inject_into_file "lib/#{app_path}/engine.rb", :after => "isolate_namespace #{app_path.camelcase}\n" do <<-RUBY
    config.generators do |g|
      g.test_framework :rspec, view_specs: false
      g.integration_tool :rspec
    end
RUBY
end

# Automount engine
append_to_file 'config/routes.rb' do <<-RUBY

# Automount engine
Rails.application.routes.draw do
  mount #{app_path.camelcase}::Engine => "/#{app_path}"
end
RUBY
end
