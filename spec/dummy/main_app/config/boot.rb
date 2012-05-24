require 'rubygems'
gemfile = File.expand_path('../../../../../Gemfile', __FILE__)

if File.exist?(gemfile)
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
end

$:.unshift File.expand_path('../../../../../lib', __FILE__)
$:.unshift File.expand_path('../../../../../spec/dummy/chili_social/lib', __FILE__)
