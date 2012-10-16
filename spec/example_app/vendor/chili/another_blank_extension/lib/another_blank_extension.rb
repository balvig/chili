require "chili"
require "another_blank_extension/engine"

module AnotherBlankExtension
  extend Chili::Activatable
  active_if { true } # edit this to activate/deactivate extension at runtime
end
