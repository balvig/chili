require "chili"
require "blank_extension/engine"

module BlankExtension
  extend Chili::Activatable
  active_if { logged_in? }
end
