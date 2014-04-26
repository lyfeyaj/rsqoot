# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'rsqoot/version'

Gem::Specification.new do |s|
  s.name             = "rsqoot"
  s.version          = RSqoot::VERSION.dup
  s.platform         = Gem::Platform::RUBY
  s.licenses         = ['MIT']
  s.summary          = %q{Wrapper for Sqoot API V2}
  s.email            = ['lyfeyaj@gmail.com']
  s.homepage         = "https://github.com/lyfeyaj/rsqoot"
  s.description      = %q{A Ruby Wrapper for Sqoot API V2.}
  s.authors          = ['Felix Liu']

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.extra_rdoc_files = ['README.md']
  s.require_paths    = ['lib']

  s.add_dependency "hashie", ">= 2.0.0"
  s.add_dependency "json", ">= 1.6.0"
  s.add_dependency "activesupport", ">= 3.0.0"

  s.add_development_dependency 'bundler', ['>= 1.0.0']
  s.add_development_dependency 'rake', ['>= 0']
  s.add_development_dependency 'rspec', ['>= 0']
end
