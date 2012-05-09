module Chili
  module Activatable
    def active_if(&block)
      @active_if = block
    end

    def active?(controller)
      controller.instance_eval(&@active_if)
    end
  end
end
