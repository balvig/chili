require 'spec_helper'

module BlankExtension ; end #Dummy engine
class BlankExtensionGenerator < Rails::Generators::NamedBase
  include Chili::GeneratorProxy
end

describe BlankExtensionGenerator do
  within_source_root do
    mkdir_p 'vendor/chili/blank_extension/config'
    touch 'vendor/chili/blank_extension/config/routes.rb'
  end

  with_args 'scaffold', 'post' do
    it "runs the scaffold controller namespaced within the extension" do
      subject.should generate("vendor/chili/blank_extension/app/controllers/blank_extension/posts_controller.rb")
    end
  end
end
