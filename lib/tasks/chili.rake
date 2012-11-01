{ spec: 'RSpec::Core::RakeTask', test: 'Rake::TestTask' }.each do |test_lib, rake_task|
  if Rake::Task.task_defined?(test_lib)

    Rake::Task[test_lib].clear
    chili_specs = "#{Chili::FEATURE_FOLDER}/**/#{test_lib}/**/*_#{test_lib}.rb"

    task = rake_task.constantize.new(test_lib)
    task.pattern = [task.pattern, chili_specs]

    namespace test_lib do
      desc "Run tests for all Chili features"
      rake_task.constantize.new(:chili) do |t|
        t.pattern = chili_specs
      end
    end
  end
end
