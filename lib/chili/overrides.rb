module Chili
  module Overrides
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.before_filter :activate_overrides
    end

    module InstanceMethods
      def activate_overrides
        Deface::Override.all.each do |o|
          extension_name = o.second.keys.first.classify
          conditions = extension_name.constantize.conditions
          override = o.second.first.second
          override.args[:disabled] = !eval(conditions)
        end
      end
    end
  end
end
