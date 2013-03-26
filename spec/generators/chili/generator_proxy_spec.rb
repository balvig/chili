require 'spec_helper'

describe Chili::GeneratorProxy do
  let(:app) { DummyApp.new }

  before do
    app.setup!
    puts `cd #{app.path} && rails g chili:feature blank`
  end


  context 'running generator from a newly created feature' do
    it "generates resources properly" do
      puts `cd #{app.path} && rails g blank_feature scaffold post`
      File.exist?(File.join(app.path, 'lib/chili/blank_feature/app/controllers/blank_feature/posts_controller.rb')).should be_true
      File.exist?(File.join(app.path, 'lib/chili/blank_feature/app/assets/stylesheets/blank_feature/posts.css')).should be_true
    end
  end

  context 'running deface override generator' do
    it "generates namespaced override properly" do
      puts `cd #{app.path} && rails g blank_feature deface:override posts/index add_links`
      File.exist?(File.join(app.path, 'lib/chili/blank_feature/app/overrides/posts/index/add_links.html.erb.deface')).should be_true
    end
  end

  context 'passing in options' do
    it "passes options on to rails generator" do
      puts `cd #{app.path} && rails g blank_feature scaffold post --stylesheets=false`
      File.exist?(File.join(app.path, 'lib/chili/blank_feature/app/controllers/blank_feature/posts_controller.rb')).should be_true
      File.exist?(File.join(app.path, 'lib/chili/blank_feature/app/assets/stylesheets/blank_feature/posts.css')).should be_false
    end
  end

end
