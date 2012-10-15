module Chili
  module GeneratorProxy
    def self.included(base)
      base.class_eval do
        argument :generator, type: :string
        argument :generator_options, type: :array, default: [], banner: "GENERATOR_OPTIONS"
        remove_class_option :skip_namespace

        def self.desc
          "Generates resources (scaffold, model, migration etc) for #{generator_name}"
        end

        def delegate
          engine = self.class.generator_name.classify.constantize
          Rails::Generators.namespace = engine
          Rails::Generators.invoke generator, generator_options, destination_root: Extension.new(engine).path, behavior: behavior
        end
      end
    end
  end
end
