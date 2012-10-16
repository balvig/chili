require 'spec_helper'

describe Chili::GeneratorProxy do
  let(:app) { DummyApp.new }

  before do
    app.setup!
    puts `cd #{app.path} && rails g chili:extension blank`
  end


  context 'running generator from a newly created extension' do
    it "generates resources properly" do
      puts `cd #{app.path} && rails g blank_extension scaffold post`
      File.exist?(File.join(app.path, 'vendor/chili/blank_extension/app/controllers/blank_extension/posts_controller.rb')).should be_true
      File.exist?(File.join(app.path, 'vendor/chili/blank_extension/app/assets/stylesheets/blank_extension/posts.css')).should be_true
    end
  end

  context 'passing in options' do
    it "passes options on to rails generator" do
      puts `cd #{app.path} && rails g blank_extension scaffold post --stylesheets=false`
      File.exist?(File.join(app.path, 'vendor/chili/blank_extension/app/controllers/blank_extension/posts_controller.rb')).should be_true
      File.exist?(File.join(app.path, 'vendor/chili/blank_extension/app/assets/stylesheets/blank_extension/posts.css')).should be_false
    end
  end

end
