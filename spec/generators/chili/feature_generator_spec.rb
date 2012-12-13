require 'spec_helper'

describe 'FeatureGenerator' do
  describe 'rails g chili:feature NAME' do
    let(:app) { DummyApp.new }
    let(:template_path) { File.expand_path("../../../dummy/blank_feature", __FILE__) }

    before { app.setup! }

    it 'creates a new feature with a correct file structure and appends it to the gemfile' do
      puts `cd #{app.path} && rails g chili:feature blank_feature`

      Dir.glob(File.join(template_path, "**/*")).reject { |f| File.directory?(f) }.each do |template|
        result = File.join(app.path, 'lib/chili/blank_feature', template.sub(template_path, ''))
        result_text = File.open(result, 'rb').read
        template_text = File.open(template, 'rb').read
        template_text.sub!('GIT_AUTHOR',`git config user.name`.chomp) # Git author is different on each machine
        template_text.sub!('GIT_EMAIL',`git config user.email`.chomp) # Git email is different on each machine
        result_text.should == template_text
      end
    end

    it "appends new features to the chili group within the gemfile" do
      puts `cd #{app.path} && rails g chili:feature blank_feature`
      File.open(app.gemfile, 'rb').read.should include <<-RUBY.chomp
group :chili do
  gem 'blank_feature', path: 'lib/chili/blank_feature'
end
    RUBY

      puts `cd #{app.path} && rails g chili:feature another_blank_feature`
      File.open(app.gemfile, 'rb').read.should include <<-RUBY.chomp
group :chili do
  gem 'another_blank_feature', path: 'lib/chili/another_blank_feature'
  gem 'blank_feature', path: 'lib/chili/blank_feature'
end
    RUBY
    end
  end
end
