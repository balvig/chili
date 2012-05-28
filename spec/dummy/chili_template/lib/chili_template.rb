require "chili"
require "chili_template/engine"

module ChiliTemplate
  extend Chili::Activatable
  active_if { logged_in? }
end
