# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'volleycal/version'

Gem::Specification.new do |spec|
  spec.name          = 'volleycal'
  spec.version       = Volleycal::VERSION
  spec.authors       = ['Nicholas E. Rabenau']
  spec.email         = ['nerab@gmx.at']
  spec.summary       = %q{iCal of the schedule of the German Volleyball 1. Bundesliga}
  spec.description   = %q{Converts Volleyball Bundesliga information into the iCal format}
  spec.homepage      = 'https://github.com/nerab/volleycal'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'icalendar'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'rack'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'

  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'guard-minitest'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-stack_explorer'
  spec.add_development_dependency 'libnotify'
  spec.add_development_dependency 'rb-inotify'
  spec.add_development_dependency 'rb-fsevent'
  spec.add_development_dependency 'rb-readline'

  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
