module Chili
  module Generators
    class FeatureGenerator < Rails::Generators::NamedBase

      def run_plugin_generator
        ARGV[0] = feature.path
        ARGV[1] = '--mountable'
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
        require File.expand_path('../../../../chili/version', __FILE__)
        gemspec = "#{feature.name}.gemspec"
        gsub_file gemspec, '# s.add_dependency "jquery-rails"', "s.add_dependency 'chili', '~> #{Chili::VERSION.sub(/\.\d+$/,'')}'"
        gsub_file gemspec, 'TODO: Your name', `git config user.NAME`.chomp
        gsub_file gemspec, 'TODO: Your email', `git config user.email`.chomp
        gsub_file gemspec, /TODO(:\s)?/, ''
      end

      def add_gem_to_main_gemfile
        gemfile =  "../../../Gemfile"
        group = "group :chili do\n"
        append_to_file gemfile, group
        append_to_file gemfile, "  gem '#{feature.name}', path: '#{feature.path}'\nend", after: group
        gsub_file gemfile, 'end  gem', '  gem' #nasty cleanup
      end

      def remove_unused_files
        remove_dir "app/helpers/#{feature.name}"
        remove_dir 'app/views/layouts'
        remove_file 'Gemfile'
        remove_file 'Rakefile'
      end

      def remove_jquery_stuff
        gsub_file "app/assets/javascripts/#{feature.name}/application.js", "//= require jquery_ujs\n", ''
        gsub_file "app/assets/javascripts/#{feature.name}/application.js", "//= require jquery\n", ''
      end

      def chilify_application_controller
        gsub_file "app/controllers/#{feature.name}/application_controller.rb", "ActionController::Base", 'Chili::ApplicationController'
      end

      def clean_up_gitignore
        gsub_file ".gitignore", /test\/dummy.*\n/, ''
      end

      def automount_engine
        prepend_to_file 'config/routes.rb', "#{feature.name.camelcase}::Engine.automount!\n"
      end

      def include_chili_libs
        prepend_to_file "lib/#{feature.name}.rb", "require \"chili\"\n"
      end

      def include_active_if
        inject_into_file "lib/#{feature.name}.rb", after: "module #{feature.name.camelcase}\n" do <<-RUBY
  extend Chili::Activatable
  active_if { true } # edit this to activate/deactivate feature at runtime
        RUBY
        end
      end

      def add_dummy_override
        example_file_path = "app/overrides/layouts/application/example.html.erb.deface"
        create_file example_file_path do <<-RUBY
<!-- insert_bottom 'body' -->
<div style='background: #FFF;text-align: center; padding: 4px 0;position: fixed;width: 100%;z-index: 9999;top: 0;'>
  #{feature.name} active - edit/remove this file:<br/>
  <strong>#{feature.path}/#{example_file_path}</strong><br/>
  <%= link_to 'deface docs', 'https://github.com/spree/deface', target: '_blank' %>
</div>
        RUBY
        end
      end

      def add_assets_override
        create_file 'app/overrides/layouts/application/assets.html.erb.deface' do <<-RUBY
<!-- insert_bottom 'head' -->
<%= stylesheet_link_tag '#{feature.name}/application' %>
<%= javascript_include_tag '#{feature.name}/application' %>
        RUBY
        end
      end

      def add_generator_proxy
        create_file "lib/generators/#{feature.name}_generator.rb" do <<-RUBY
class #{feature.name.camelcase}Generator < Rails::Generators::Base
  include Chili::GeneratorProxy
end
        RUBY
        end
      end

      protected

      def feature
        @feature ||= Chili::Feature.new(ARGV[0])
      end
    end
  end
end
