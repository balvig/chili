module Chili
  module Tasks
    # App tasks
    require 'rails'
    load 'rails/tasks/engine.rake'

    # Gem tasks
    require 'bundler/gem_helper'
    Bundler::GemHelper.install_tasks
  end
end
