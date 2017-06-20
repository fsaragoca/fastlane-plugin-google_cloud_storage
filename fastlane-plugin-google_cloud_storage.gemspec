# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/google_cloud_storage/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-google_cloud_storage'
  spec.version       = Fastlane::GoogleCloudStorage::VERSION
  spec.author        = 'Fernando Saragoca'
  spec.email         = 'fsaragoca@me.com'

  spec.summary       = 'Google Cloud Storage'
  spec.homepage      = "https://github.com/fsaragoca/fastlane-plugin-google_cloud_storage"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w[README.md LICENSE]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'google-cloud-storage'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 2.0.5'
end
