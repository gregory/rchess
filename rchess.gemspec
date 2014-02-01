# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rchess/version'

Gem::Specification.new do |spec|
  spec.name          = "rchess"
  spec.version       = Rchess::VERSION
  spec.authors       = ["gregory"]
  spec.email         = ["greg2502@gmail.com"]
  spec.description   = %q{A ruby chess game}
  spec.summary       = %q{no need for summary, go check the source}
  spec.homepage      = "http://github.com/gregory/rchess"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rake", "~> 10.1.1"
  spec.add_dependency "wisper", "~> 1.2.1"

  spec.add_development_dependency "bundler", "~> 1.3"

end
