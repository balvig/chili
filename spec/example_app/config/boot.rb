# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../../../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
$:.unshift File.expand_path('../../../../../lib', __FILE__)
$:.unshift File.expand_path('../../lib/chili/social_feature/lib', __FILE__)
$:.unshift File.expand_path('../../lib/chili/invites_feature/lib', __FILE__)
