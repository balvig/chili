module Chili
  module Overrides
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.before_filter :activate_overrides
    end

    module InstanceMethods
      def activate_overrides
        Deface::Override.all.values.map(&:values).flatten.each do |override|
          engine = override.railtie_class.constantize.parent
          override.args[:disabled] = !engine.active?(self) if engine.respond_to?(:active?)
        end
      end
    end
  end
end
