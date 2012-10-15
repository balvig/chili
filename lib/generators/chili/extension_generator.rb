module Chili
  module Generators
    class ExtensionGenerator < Rails::Generators::NamedBase

      def run_plugin_generator
        ARGV[0] = extension.path
        ARGV[1] = "--mountable"
        ARGV[2] = '--skip-test-unit'
        ARGV[3] = '--skip-bundle'

        require 'rails/generators'
        require 'rails/generators/rails/plugin_new/plugin_new_generator'
        Rails::Generators::PluginNewGenerator.start
      end

      def reset_destination_root
        self.destination_root = ''
      end

      def edit_gemspec
        require File.expand_path('../../../chili/version', __FILE__)
        gemspec = "#{extension.name}.gemspec"
        gsub_file gemspec, '# s.add_dependency "jquery-rails"', "s.add_dependency 'chili', '~> #{Chili::VERSION}'"
        gsub_file gemspec, 'TODO: Your name', `git config user.NAME`.chomp
        gsub_file gemspec, 'TODO: Your email', `git config user.email`.chomp
        gsub_file gemspec, /TODO(:\s)?/, ''
      end

      def add_gem_to_main_gemfile
        gemfile =  "../../../Gemfile"
        group = "group :chili do\n"
        append_to_file gemfile, group
        append_to_file gemfile, "  gem '#{extension.name}', path: '#{extension.path}'\nend", after: group
        gsub_file gemfile, 'end  gem', '  gem' #nasty cleanup
      end

      def remove_unused_files
        remove_dir "app/helpers/#{extension.name}"
        remove_dir 'app/views/layouts'
        remove_file 'Gemfile'
        remove_file 'Rakefile'
      end

      def remove_jquery_stuff
        gsub_file "app/assets/javascripts/#{extension.name}/application.js", "//= require jquery_ujs\n", ''
        gsub_file "app/assets/javascripts/#{extension.name}/application.js", "//= require jquery\n", ''
      end

      def chilify_application_controller
        gsub_file "app/controllers/#{extension.name}/application_controller.rb", "ActionController::Base", 'Chili::ApplicationController'
      end

      def clean_up_gitignore
        gsub_file ".gitignore", /test\/dummy.*\n/, ''
      end

      def automount_engine
        prepend_to_file 'config/routes.rb', "#{extension.name.camelcase}::Engine.automount!\n"
      end

      def include_chili_libs
        prepend_to_file "lib/#{extension.name}.rb", "require \"chili\"\n"
      end

      def include_active_if
        inject_into_file "lib/#{extension.name}.rb", after: "module #{extension.name.camelcase}\n" do <<-RUBY
  extend Chili::Activatable
  active_if { true } # edit this to activate/deactivate extension at runtime
        RUBY
        end
      end

      def add_dummy_override
        example_file_path = "app/overrides/layouts/application/example.html.erb.deface"
        create_file example_file_path do <<-RUBY
<!-- insert_bottom 'body' -->
<div style='background: #FFF;text-align: center; padding: 4px 0;position: fixed;width: 100%;z-index: 9999;top: 0;'>
  #{extension.name} active - edit/remove this file:<br/>
  <strong>#{extension.path}/#{example_file_path}</strong><br/>
  <%= link_to 'deface docs', 'https://github.com/spree/deface', target: '_blank' %>
</div>
        RUBY
        end
      end

      def add_assets_override
        create_file 'app/overrides/layouts/application/assets.html.erb.deface' do <<-RUBY
<!-- insert_bottom 'head' -->
<%= stylesheet_link_tag '#{extension.name}/application' %>
<%= javascript_include_tag '#{extension.name}/application' %>
        RUBY
        end
      end

      def add_generators
        create_file "lib/generators/#{extension.name}_generator.rb" do <<-RUBY
class #{extension.name.camelcase}Generator < Rails::Generators::NamedBase
  include Chili::Generators
end
        RUBY
        end
      end

      protected

      def extension
        @extension ||= Chili::Extension.new(ARGV[0])
      end
    end
  end
end
