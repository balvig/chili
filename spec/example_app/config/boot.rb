require 'rubygems'
gemfile = File.expand_path('../../../../../Gemfile', __FILE__)

if File.exist?(gemfile)
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
end

$:.unshift File.expand_path('../../../../../lib', __FILE__)
$:.unshift File.expand_path('../../vendor/chili/social_feature/lib', __FILE__)
$:.unshift File.expand_path('../../vendor/chili/invites_feature/lib', __FILE__)
