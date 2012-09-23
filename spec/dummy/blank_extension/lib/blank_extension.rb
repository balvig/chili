require "chili"
require "blank_extension/engine"

module BlankExtension
  extend Chili::Activatable
  active_if { true } # edit this to activate/deactivate extension at runtime
end
