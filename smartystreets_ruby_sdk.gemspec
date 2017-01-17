# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smartystreets_ruby_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'smartystreets_ruby_sdk'
  spec.version       = SmartystreetsRubySdk::VERSION
  spec.authors       = ['SmartyStreets SDK Team']
  spec.license       = 'Apache-2.0'
  spec.email         = ['support@smartystreets.com']
  spec.summary       = 'An official library for the SmartyStreets APIs'
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

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
