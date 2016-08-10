# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'anki/version'

Gem::Specification.new do |spec|
  spec.name          = "anki"
  spec.version       = Anki::VERSION
  spec.authors       = ["Dennis Martinez"]
  spec.email         = ["dennis@dennmart.com"]
  spec.summary       = "Generate decks ready to be imported into Anki!"
  spec.description   = "Generate decks ready to be imported into Anki! Just pass an array of hashes and get back a string that you can save in a file and import directly into Anki."
  spec.homepage      = "https://github.com/dennmart/anki"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 1.9.3'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "fakefs", "~> 0.5"
end
