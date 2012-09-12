require "chili"
require "invites_extension/engine"

module InvitesExtension
  extend Chili::Activatable
  active_if { logged_in? }
end
