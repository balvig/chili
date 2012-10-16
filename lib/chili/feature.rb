module Chili
  class Feature
    def initialize(short_name)
      @short_name = short_name
    end

    def name
      @short_name.to_s.underscore.gsub('_feature','') + '_feature'
    end

    def path
      "vendor/chili/#{name}"
    end
  end
end
