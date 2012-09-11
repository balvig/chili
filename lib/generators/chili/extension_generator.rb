module Chili
  module Generators
    class ExtensionGenerator < Rails::Generators::NamedBase
      NAME = "#{ARGV[0]}_extension"
      PATH = "vendor/chili/#{NAME}"

      def run_plugin_generator
        ARGV[0] = PATH
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
        gemspec = "#{NAME}.gemspec"
        gsub_file gemspec, '# s.add_dependency "jquery-rails"', "s.add_dependency 'chili', '~> #{Chili::VERSION}'"
        gsub_file gemspec, 'TODO: Your name', `git config user.NAME`.chomp
        gsub_file gemspec, 'TODO: Your email', `git config user.email`.chomp
        gsub_file gemspec, /TODO(:\s)?/, ''
      end

      def add_gem_to_main_gemfile
        append_to_file "../../../Gemfile", "gem '#{NAME}', path: '#{PATH}'"
      end

      def remove_unused_files
        remove_dir "app/controllers/#{NAME}"
        remove_dir "app/helpers/#{NAME}"
        remove_dir 'app/views/layouts'
        remove_file 'Gemfile'
        remove_file 'Rakefile'
      end

      def remove_jquery_stuff
        gsub_file "app/assets/javascripts/#{NAME}/application.js", "//= require jquery_ujs\n", ''
        gsub_file "app/assets/javascripts/#{NAME}/application.js", "//= require jquery\n", ''
      end

      def set_up_custom_generator
        inject_into_file "lib/#{NAME}/engine.rb", after: "isolate_namespace #{NAME.camelcase}\n" do <<-RUBY
    config.generators do |g|
      g.scaffold_controller :chili
    end
        RUBY
        end
      end

      def set_up_rspec
        inject_into_file "lib/#{NAME}/engine.rb", :after => " g.scaffold_controller :chili\n" do <<-RUBY
      g.test_framework :rspec, view_specs: false, routing_specs: false, controller_specs: false
      g.integration_tool :rspec
        RUBY
        end
      end

      def clean_up_gitignore
        gsub_file ".gitignore", /test\/dummy.*\n/, ''
      end

      def automount_engine
        prepend_to_file 'config/routes.rb', "#{NAME.camelcase}::Engine.automount!\n"
      end

      def include_chili_libs
        prepend_to_file "lib/#{NAME}.rb", "require \"chili\"\n"
      end

      def include_active_if
        inject_into_file "lib/#{NAME}.rb", :after => "module #{NAME.camelcase}\n" do <<-RUBY
  extend Chili::Activatable
  active_if { logged_in? }
        RUBY
        end
      end

      def add_dummy_override
        example_file_path = "app/overrides/layouts/application/example.html.erb.deface"
        create_file example_file_path do <<-RUBY
<!-- insert_bottom 'body' -->
<div style='background: #FFF;text-align: center; padding: 4px 0;position: fixed;width: 100%;z-index: 9999;top: 0;'>
  #{NAME} active - edit/remove this file:<br/>
  <strong>#{PATH}/#{example_file_path}</strong><br/>
  <%= link_to 'deface docs', 'https://github.com/railsdog/deface', target: '_blank' %>
</div>
        RUBY
        end
      end

      def add_assets_override
        create_file 'app/overrides/layouts/application/assets.html.erb.deface' do <<-RUBY
<!-- insert_bottom 'head' -->
<%= stylesheet_link_tag '#{NAME}/application' %>
<%= javascript_include_tag '#{NAME}/application' %>
        RUBY
        end
      end
    end

  end
end
