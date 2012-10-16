require 'rubygems'
gemfile = File.expand_path('../../../../../Gemfile', __FILE__)

if File.exist?(gemfile)
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
end

$:.unshift File.expand_path('../../../../../lib', __FILE__)
$:.unshift File.expand_path('../../lib/chili/social_feature/lib', __FILE__)
$:.unshift File.expand_path('../../lib/chili/invites_feature/lib', __FILE__)
