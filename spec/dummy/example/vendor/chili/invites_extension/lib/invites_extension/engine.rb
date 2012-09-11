module InvitesExtension
  class Engine < ::Rails::Engine
    isolate_namespace InvitesExtension
    config.generators do |g|
      g.scaffold_controller :chili
      g.test_framework :rspec, view_specs: false, routing_specs: false, controller_specs: false
      g.integration_tool :rspec
    end
  end
end
