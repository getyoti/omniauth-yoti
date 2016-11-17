# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/yoti/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-yoti'
  spec.version       = Omniauth::Yoti::VERSION
  spec.authors       = ['Vasile Zaremba']
  spec.email         = ['vasile.zaremba@yoti.com']

  spec.summary       = 'Yoti strategy for OmniAuth'
  spec.homepage      = 'TODO: Put your gem website or public repo URL here.'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'omniauth', '~> 1.3'
  spec.add_dependency 'yoti'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
end
