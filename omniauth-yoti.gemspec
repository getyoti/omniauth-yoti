# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/yoti/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-yoti'
  spec.version       = Omniauth::Yoti::VERSION
  spec.authors       = ['Sebastian Zaremba']
  spec.email         = ['tech@yoti.com']

  spec.summary       = 'Yoti strategy for OmniAuth'
  spec.homepage      = 'https://github.com/getyoti/omniauth-yoti'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1.9'

  spec.add_dependency 'omniauth', '~> 1.6'
  spec.add_dependency 'yoti', '~> 1.1.0'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 12.1'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'simplecov', '~> 0.15'
  spec.add_development_dependency 'webmock', '~> 3.0'
end
