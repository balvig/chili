# Uses Chili::ApplicationController and the layout from the main app
remove_dir 'app/controllers'
empty_directory 'app/controllers'
remove_dir 'app/views/layouts'

# Add directory for deface overrides
empty_directory 'app/overrides'

# Uses Gemfile from main app
remove_file 'Gemfile'

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
