module Chili
  class Engine < ::Rails::Engine
    initializer 'chili.deface' do |app|
      app.config.deface.namespaced = true
    end

    initializer 'chili.controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        include Chili::Overrides
      end
    end
  end
end
