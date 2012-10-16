require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require
require "chili"
Dir.glob(File.expand_path('../../vendor/chili/*', __FILE__)).each do |dir|
  require File.basename(dir)
end

module Dummy
  class Application < Rails::Application
  end
end
