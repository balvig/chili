require "chili"
require "social_feature/engine"

module SocialFeature
  extend Chili::Activatable
  active_if { logged_in? && current_user.admin? }
end
