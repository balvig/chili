class DummyApp
  def path
    File.expand_path("../../dummy/app", __FILE__)
  end

  def gemfile
    File.join(path, 'Gemfile')
  end

  def setup!
    FileUtils.rm_rf File.join(path, 'lib')
    FileUtils.rm_rf gemfile
    File.open(gemfile, 'w') do |f|
      f.write <<-RUBY
group :development do
  gem 'somegem'
end
      RUBY
    end
  end
end
