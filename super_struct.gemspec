# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'super_struct/version'

Gem::Specification.new do |spec|
  spec.name          = 'super_struct'
  spec.version       = SuperStruct::VERSION
  spec.authors       = ['Bram Swenson']
  spec.email         = ['bram@craniumisajar.com']
  spec.summary       = %q{Extended struct constructors}
  spec.description   = %q{Extended struct constructors}
  spec.homepage      = 'http://github.com/bramswenson/super_struct'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',     '~> 1.7'
  spec.add_development_dependency 'rake',        '~> 10.0'
  spec.add_development_dependency 'rspec',       '~> 3.1.0'
  spec.add_development_dependency 'guard',       '~> 2.11.1'
  spec.add_development_dependency 'guard-rspec', '~> 4.5.0'
  spec.add_development_dependency 'pry',         '~> 0.10.1'
  spec.add_development_dependency 'byebug',      '~> 3.5.1'
end
