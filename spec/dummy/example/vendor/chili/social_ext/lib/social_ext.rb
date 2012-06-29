require "chili"
require "social_ext/engine"

module SocialExt
  extend Chili::Activatable
  active_if { logged_in? && current_user.admin? }
end
