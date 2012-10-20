module Chili
  module Activatable
    def self.extended(base)
      base.send(:unloadable) if base.respond_to?(:unloadable)
    end

    def active_if(&block)
      @active_if = block
    end

    def active?(controller)
      controller.instance_eval(&@active_if)
    end
  end
end
