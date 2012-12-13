module Chili
  class Feature
    attr_reader :name
    def initialize(name)
      @name = name.to_s.underscore
    end

    def path
      "#{FEATURE_FOLDER}/#{name}"
    end
  end
end
