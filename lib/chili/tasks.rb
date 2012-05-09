module Chili
  module Tasks
    # Bundler
    begin
      require 'bundler/setup'
    rescue LoadError
      puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
    end

    # App tasks
    require 'rails'
    load 'rails/tasks/engine.rake'

    # Gem tasks
    require 'bundler/gem_helper'
    Bundler::GemHelper.install_tasks

  end
end
