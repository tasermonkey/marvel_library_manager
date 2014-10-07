# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'marvel_library_manager/version'

Gem::Specification.new do |spec|
  spec.name          = "marvel_library_manager"
  spec.version       = MarvelLibraryManager::VERSION
  spec.authors       = ["James Stapleton"]
  spec.email         = ["github@tasermonkeys.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($\) #`git ls-files -z`.split("\x0")
  spec.executables   = ["marvel_library_manager"]
  puts spec.executables
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "nokogiri", "~> 1.6"
end
