module Chili
  class BaseGenerator < Rails::Generators::NamedBase
    def delegate
      engine = self.class.parent
      Rails::Generators.namespace = engine
      Rails::Generators.invoke self.class.name.demodulize.downcase, ARGV, destination_root: Extension.new(engine).path, skip_namespace: true, behavior: behavior
    end
  end
end
