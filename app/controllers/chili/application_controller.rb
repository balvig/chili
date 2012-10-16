module Chili
  class ApplicationController  < ::ApplicationController
    before_filter :activate_feature

    private
    def activate_feature
      raise ActionController::RoutingError, 'Feature Disabled' unless self.class.parent.active?(self)
    end
  end
end
