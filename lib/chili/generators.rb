module Chili
  module Generators
    def self.included(base)
      base.class_eval do
        remove_class_option :skip_namespace

        def self.desc
          "Generates Rails resources (scaffold, model, migration etc) for #{generator_name}"
        end

        def delegate
          engine = self.class.parent
          Rails::Generators.namespace = engine
          Rails::Generators.invoke ARGV.shift, ARGV, destination_root: Extension.new(engine).path, behavior: behavior
        end
      end
    end
  end
end
