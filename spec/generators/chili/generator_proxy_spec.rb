require 'spec_helper'
require 'rails/generators'

module BlankExtension ; end #Dummy engine
class BlankExtensionGenerator < Rails::Generators::Base
  include Chili::GeneratorProxy
end

describe BlankExtensionGenerator do
  context 'given no options' do
    before do
      ARGV.clear
      ARGV << 'scaffold'
      ARGV << 'post'
    end

    it "works" do
      binding.pry
      #BlankExtensionGenerator.start#(ARGV, destination_root: '/tmp')
    end

  end

end
