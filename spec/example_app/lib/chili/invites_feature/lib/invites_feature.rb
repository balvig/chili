require "chili"
require "invites_feature/engine"

module InvitesFeature
  extend Chili::Base
  active_if { logged_in? }
end
