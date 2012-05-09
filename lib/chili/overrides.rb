module Chili
  module Overrides
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.before_filter :activate_overrides
    end

    module InstanceMethods
      def activate_overrides
        Deface::Override.all.each do |o|
          engine = o.second.keys.first.camelcase.constantize
          override = o.second.first.second
          override.args[:disabled] = !engine.active?(self)
        end
      end
    end
  end
end
