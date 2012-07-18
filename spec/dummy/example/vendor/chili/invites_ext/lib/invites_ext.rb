require "chili"
require "invites_ext/engine"

module InvitesExt
  extend Chili::Activatable
  active_if { logged_in? }
end
