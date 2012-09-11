require 'spec_helper'

describe 'ChiliGenerator' do
  describe 'rails g chili EXTENSION_NAME' do
    let(:app_path) { File.expand_path("../../../dummy/example", __FILE__) }
    let(:template_path) { File.expand_path("../../../dummy/blank_extension", __FILE__) }

    before do
      FileUtils.rm_rf File.join(app_path, 'vendor/chili/blank_extension')
      FileUtils.rm_rf File.join(app_path, 'Gemfile')
      FileUtils.touch File.join(app_path, 'Gemfile')
    end

    it 'creates a new extension with a correct file structure' do
      puts `cd #{app_path} && rails g chili:extension blank`

      Dir.glob(File.join(template_path, "**/*")).reject { |f| File.directory?(f) }.each do |template|
        result = File.join(app_path, 'vendor/chili/blank_extension', template.sub(template_path, ''))
        result_text = File.open(result, 'rb').read
        template_text = File.open(template, 'rb').read
        template_text.sub!('GIT_AUTHOR',`git config user.name`.chomp) # Git author is different on each machine
        template_text.sub!('GIT_EMAIL',`git config user.email`.chomp) # Git email is different on each machine
        result_text.should == template_text
      end
    end
  end
end
