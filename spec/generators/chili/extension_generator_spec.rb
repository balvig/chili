require 'spec_helper'

describe 'ChiliGenerator' do
  describe 'rails g chili EXTENSION_NAME' do
    let(:app) { DummyApp.new }
    let(:template_path) { File.expand_path("../../../dummy/blank_extension", __FILE__) }

    before do
      app.setup!
    end

    it 'creates a new extension with a correct file structure and appends it to the gemfile' do
      puts `cd #{app.path} && rails g chili:extension blank`

      Dir.glob(File.join(template_path, "**/*")).reject { |f| File.directory?(f) }.each do |template|
        result = File.join(app.path, 'vendor/chili/blank_extension', template.sub(template_path, ''))
        result_text = File.open(result, 'rb').read
        template_text = File.open(template, 'rb').read
        template_text.sub!('GIT_AUTHOR',`git config user.name`.chomp) # Git author is different on each machine
        template_text.sub!('GIT_EMAIL',`git config user.email`.chomp) # Git email is different on each machine
        result_text.should == template_text
      end
    end

    it "appends new extensions to the chili group within the gemfile" do
      puts `cd #{app.path} && rails g chili:extension blank`
      File.open(app.gemfile, 'rb').read.should include <<-RUBY.chomp
group :chili do
  gem 'blank_extension', path: 'vendor/chili/blank_extension'
end
    RUBY

      puts `cd #{app.path} && rails g chili:extension another_blank`
      File.open(app.gemfile, 'rb').read.should include <<-RUBY.chomp
group :chili do
  gem 'another_blank_extension', path: 'vendor/chili/another_blank_extension'
  gem 'blank_extension', path: 'vendor/chili/blank_extension'
end
    RUBY
    end
  end
end
