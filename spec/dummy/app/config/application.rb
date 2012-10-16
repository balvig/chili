require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require
require "chili"

module Dummy
  class Application < Rails::Application
  end
end

