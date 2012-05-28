require 'spec_helper'

describe 'Chili Binary' do
  describe 'chili EXTENSION_NAME' do
    let(:chili) { File.expand_path("../../../bin/chili", __FILE__) }
    let(:result_path) { File.expand_path("../../result/", __FILE__) }
    let(:source_path) { File.expand_path("../../dummy/chili_template", __FILE__) }

    before do
      FileUtils.rm_rf(result_path)
      FileUtils.mkdir(result_path)
    end

    it 'creates a new extension with a correct file structure' do
      `cd #{result_path} && MAIN_APP= #{chili} template`

      Dir.glob(File.join(source_path, "**/*")).reject { |f| File.directory?(f) }.each do |source|
        result = File.join(result_path, 'chili_template', source.sub(source_path, ''))
        File.open(source, 'rb').read.should == File.open(result, 'rb').read
      end
    end
  end
end
