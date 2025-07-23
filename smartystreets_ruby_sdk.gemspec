# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smartystreets_ruby_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'smartystreets_ruby_sdk'
  spec.version       = SmartyStreets::VERSION
  spec.authors       = ['SmartyStreets SDK Team']
  spec.license       = 'Apache-2.0'
  spec.email         = ['support@smartystreets.com']
  spec.summary       = 'An official library for the SmartyStreets APIs'
  spec.homepage      = 'https://github.com/smartystreets/smartystreets-ruby-sdk'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.4.6'
  spec.add_development_dependency 'minitest', '~> 5.8', '>= 5.8.3'
  spec.add_development_dependency 'rake', '~> 13.0.6'
  spec.add_development_dependency 'simplecov', '>= 0.21.2'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
