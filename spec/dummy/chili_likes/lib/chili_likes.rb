require "chili"
require "chili_likes/engine"

module ChiliLikes
  extend Chili::Activatable
  active_if { logged_in? && current_user.admin? }
end
