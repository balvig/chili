require "chili"
require "chili_social/engine"

module ChiliSocial
  extend Chili::Activatable
  active_if { logged_in? && current_user.admin? }
end
