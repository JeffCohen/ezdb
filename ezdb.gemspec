# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ezdb/version'

Gem::Specification.new do |spec|
  spec.name          = "ezdb"
  spec.version       = EZDB::VERSION
  spec.authors       = ["Jeff Cohen"]
  spec.email         = ["cohen.jeff@gmail.com"]
  spec.description   = "Easier database migrations"
  spec.summary       = "For educational purposes only."
  spec.homepage      = "http://jeffcohen.github.io/ezdb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = []
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", '~> 10.0', '>= 10.0.0'
end
