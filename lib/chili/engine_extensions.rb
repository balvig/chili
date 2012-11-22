module Chili
  module EngineExtensions
    def self.extended(base)
      base.rake_tasks do
        next if self.is_a?(Rails::Application)
        next unless has_migrations?

        namespace railtie_name do
          namespace :db do
            desc "Copy and migrate migrations from #{railtie_name}"
            task :migrate do
              Rake::Task["#{railtie_name}:install:migrations"].invoke
              Rake::Task["db:migrate"].invoke
            end
          end
        end
      end
    end

    def automount!(path = nil)
      engine = self
      path ||= 'chili/' + engine.parent.to_s.underscore
      Rails.application.routes.draw do
        mount engine => path
      end
    end
  end
end
