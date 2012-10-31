namespace :spec do
  desc "Run tests for all Chili features"
  RSpec::Core::RakeTask.new(:chili) do |t|
    t.pattern = "./lib/chili/**/spec/**/*_spec.rb"
  end
end

task default: 'spec:chili'
