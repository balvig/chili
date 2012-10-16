require "chili"
require "invites_feature/engine"

module InvitesFeature
  extend Chili::Activatable
  active_if { logged_in? }
end
