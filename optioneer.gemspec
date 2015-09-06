# coding: utf-8
# rubocop:disable LineLength
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'optioneer/version'

Gem::Specification.new do |spec|
  spec.name          = 'optioneer'
  spec.version       = Optioneer::VERSION
  spec.required_ruby_version = '>= 1.9.3'
  spec.authors       = ['Seapagan']
  spec.email         = ['seapagan@gmail.com']

  spec.summary       = 'A Ruby Gem to parse Command Line Options. Yes, another one!'
  spec.homepage      = 'https://github.com/seapagan/optioneer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'inch'
  spec.add_development_dependency 'simplecov', '~> 0.10'
end
