require "chili"
require "template_ext/engine"

module TemplateExt
  extend Chili::Activatable
  active_if { logged_in? }
end
