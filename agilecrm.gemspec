# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'agilecrm-wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = 'agilecrm-wrapper'
  spec.version       = AgileCRMWrapper::VERSION
  spec.authors       = ['Cyle']
  spec.email         = ['cylehunter33@gmail.com']
  spec.summary       = 'Ruby wrapper for Agile CRM API.'
  spec.description   = 'Ruby wrapper for Agile CRM API.'
  spec.homepage      = 'https://github.com/nozpheratu/agilecrm-wrapper'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'hashie'
  spec.add_dependency 'json'
  spec.add_dependency 'retriable'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'sinatra'
end
