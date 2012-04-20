module Chili
  module Tasks
    # Bundler
    begin
      require 'bundler/setup'
    rescue LoadError
      puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
    end

    # Rdoc
    begin
      require 'rdoc/task'
    rescue LoadError
      require 'rdoc/rdoc'
      require 'rake/rdoctask'
      RDoc::Task = Rake::RDocTask
    end

    RDoc::Task.new(:rdoc) do |rdoc|
      rdoc.rdoc_dir = 'rdoc'
      rdoc.title    = 'CommentsExtension'
      rdoc.options << '--line-numbers'
      rdoc.rdoc_files.include('README.rdoc')
      rdoc.rdoc_files.include('lib/**/*.rb')
    end

    # App tasks
    require 'rails'
    load 'rails/tasks/engine.rake'

    # Gem tasks
    require 'bundler/gem_helper'
    Bundler::GemHelper.install_tasks

  end
end
