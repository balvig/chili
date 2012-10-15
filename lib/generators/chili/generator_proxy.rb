module Chili
  module GeneratorProxy
    def self.included(base)
      base.class_eval do
        remove_class_option :skip_namespace

        def self.desc
          "Generates Rails resources (scaffold, model, migration etc) for #{generator_name}"
        end

        def delegate
          engine = self.class.generator_name.classify.constantize
          Rails::Generators.namespace = engine
          Rails::Generators.invoke name, args, destination_root: Extension.new(engine).path, behavior: behavior
        end
      end
    end
  end
end
