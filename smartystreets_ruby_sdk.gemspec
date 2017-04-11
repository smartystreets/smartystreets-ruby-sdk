# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smartystreets_ruby_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'smartystreets_ruby_sdk'
  spec.version       = Smartystreets::VERSION
  spec.authors       = ['Smartystreets SDK Team']
  spec.license       = 'Apache-2.0'
  spec.email         = ['support@smartystreets.com']
  spec.summary       = 'An official library for the Smartystreets APIs'
  spec.homepage      = 'https://github.com/smartystreets/smartystreets-ruby-sdk'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.8', '>= 5.8.3'
  spec.add_development_dependency 'simplecov', '~> 0.12.0'
end
