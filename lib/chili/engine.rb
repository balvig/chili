module Chili
  class Engine < ::Rails::Engine
    initializer 'chili.controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        include Chili::Overrides
      end
    end
  end
end
