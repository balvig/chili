require "chili"
require "chili_invites/engine"

module ChiliInvites
  extend Chili::Activatable
  active_if { logged_in? }
end
