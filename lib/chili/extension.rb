module Chili
  class Extension
    def initialize(short_name)
      @short_name = short_name
    end

    def name
      @short_name.to_s.underscore.gsub('_extension','') + '_extension'
    end

    def path
      "vendor/chili/#{name}"
    end
  end
end
