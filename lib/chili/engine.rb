module Chili
  class Engine < ::Rails::Engine

    initializer "chili.add_autoload_paths", before: :set_autoload_paths do |app|
      app.config.autoload_paths += Dir["#{app.config.root}/#{FEATURE_FOLDER}/*/lib"]
    end

    initializer 'chili.deface'  do |app|
      app.config.deface.namespaced = true
    end

    initializer 'chili.controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        include Chili::Overrides
      end
    end
  end
end
