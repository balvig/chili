namespace :spec do
  desc "Run tests for all Chili features"
  RSpec::Core::RakeTask.new(:chil) do |t|
    t.pattern = "./lib/chili/**/spec/**/*_spec.rb"
  end
end

