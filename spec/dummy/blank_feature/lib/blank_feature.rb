require "chili"
require "blank_feature/engine"

module BlankFeature
  extend Chili::Base
  active_if { true } # edit this to activate/deactivate feature at runtime
end
