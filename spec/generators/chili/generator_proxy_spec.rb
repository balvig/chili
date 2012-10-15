require 'spec_helper'

module BlankExtension ; end #Dummy engine
class BlankExtensionGenerator < Rails::Generators::Base
  include Chili::GeneratorProxy
end

describe BlankExtensionGenerator do
  within_source_root do
    FileUtils.mkdir_p 'vendor/chili/blank_extension/config'
    FileUtils.touch 'vendor/chili/blank_extension/config/routes.rb'
  end

  #TODO: Want to write spec testing options but some rspec and command line treats ARGV differently...
  with_args(ARGV = %w{ scaffold post }) do
    it "runs the scaffold controller namespaced within the extension" do
      subject.should generate("vendor/chili/blank_extension/app/assets/stylesheets/blank_extension/posts.css")
    end
  end

end
