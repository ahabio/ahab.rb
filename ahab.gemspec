#encoding: utf-8

Gem::Specification.new do |s|
  s.name        = "ahab"
  s.version     = "0.0.1"
  s.executables << 'ahab'
  s.platform    = Gem::Platform::RUBY
  s.license     = "Apache License Version 2.0"
  s.authors     = ["James A. Rosen", "Stefan Vizzari", "Ana Martínez"]
  s.email       = ["james.a.rosen+ahab@gmail.com"]
  s.homepage    = "http://github.com/zendesk/ahab.rb"
  s.summary     = "Ruby client for the AHAB asset packaging system."
  s.description = s.summary

  s.required_rubygems_version = ">= 1.3.6"

  s.add_runtime_dependency 'multi_json'
  s.add_runtime_dependency 'typhoeus'

  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'

  s.files        = Dir.glob("{bin,lib}/**/*") + %w(README.md HISTORY.md LICENSE)
  s.test_files   = Dir.glob("features/**/*")
  s.require_path = 'lib'
end
