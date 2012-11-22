require "chili/activatable"
require "chili/engine_extensions"

module Chili
  module Base
    def self.extended(base)
      base.extend(Activatable)
      base::Engine.extend(EngineExtensions)
    end
  end
end
