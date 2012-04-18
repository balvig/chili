module Chili
  class ApplicationController  < ::ApplicationController
    before_filter :activate_extension

    private
    def activate_extension
      raise ActionController::RoutingError, 'Extension Disabled' unless eval(self.class.parent.conditions)
    end
  end
end
