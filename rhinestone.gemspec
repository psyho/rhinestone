# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rhinestone/version"

Gem::Specification.new do |s|
  s.name        = "rhinestone"
  s.version     = Rhinestone::VERSION
  s.authors     = ["Adam Pohorecki"]
  s.email       = ["adam@pohorecki.pl"]
  s.homepage    = "http://github.com/psyho/rhinestone"
  s.summary     = %q{Proxy to rubygems}
  s.description = %q{Proxy to rubygems that returns the latest cached version of the requested url and updates the cache in the background}

  s.rubyforge_project = "rhinestone"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'dependor'
  s.add_runtime_dependency 'goliath'
  s.add_runtime_dependency 'em-http-request'

  s.add_development_dependency 'rake'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'

  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'libnotify'
end
