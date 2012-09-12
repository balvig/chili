require "chili"
require "social_extension/engine"

module SocialExtension
  extend Chili::Activatable
  active_if { logged_in? && current_user.admin? }
end
