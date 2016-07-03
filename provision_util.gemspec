# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'provision_util/version'

Gem::Specification.new do |spec|
  spec.name          = "provision_util"
  spec.version       = ProvisionUtil::VERSION
  spec.authors       = ["punksta"]
  spec.email         = ["skinnystas@gmail.com"]

  spec.summary       = %q{Little library to working with provision profiles and certificates}
  spec.description   = %q{You can read provision profile into Hash, get signed certificate
and verify it with p12 files }
  spec.homepage      = 'https://github.com/punksta/provision_util'
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'nokogiri'
  spec.add_dependency 'plist'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
