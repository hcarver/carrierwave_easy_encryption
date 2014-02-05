# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave_easy_encryption/version'

Gem::Specification.new do |spec|
  spec.name          = "carrierwave_easy_encryption"
  spec.version       = CarrierWave::EasyEncryption::VERSION
  spec.authors       = ["Hywel Carver"]
  spec.email         = ["h@londonstartuptech.com"]
  spec.description   = %q{The easiest way to encrypt your carrierwave files}
  spec.summary       = %q{Encrypt all of your carrierwave files with the minimum of effort and the minimum of configuration}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "gibberish", "~> 1.4.0"
end
