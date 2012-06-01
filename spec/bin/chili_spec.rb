require 'spec_helper'

describe 'Chili Binary' do
  describe 'chili EXTENSION_NAME' do
    let(:chili) { File.expand_path("../../../bin/chili", __FILE__) }
    let(:app_path) { File.expand_path("../../dummy/example", __FILE__) }
    let(:template_path) { File.expand_path("../../dummy/template", __FILE__) }

    before do
      FileUtils.rm_rf File.join(app_path, 'vendor/chili_template')
      FileUtils.rm_rf File.join(app_path, 'Gemfile')
      FileUtils.touch File.join(app_path, 'Gemfile')
    end

    it 'creates a new extension with a correct file structure' do
      `cd #{app_path} && #{chili} new template`

      Dir.glob(File.join(template_path, "**/*")).reject { |f| File.directory?(f) }.each do |source|
        result = File.join(app_path, 'vendor/chili_template', source.sub(template_path, ''))
        puts source
        puts result
        File.open(result, 'rb').read.should == File.open(source, 'rb').read
      end
    end
  end
end
