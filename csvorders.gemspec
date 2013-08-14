# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csvorders/version'

Gem::Specification.new do |spec|
  spec.name          = "csvorders"
  spec.version       = Csvorders::VERSION
  spec.authors       = ["Troy Denkinger"]
  spec.email         = ["tdenkinger@gmail.com"]
  spec.description   = %q{CSV-based order handling}
  spec.summary       = %q{CSV-based order handling}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.13"
  spec.add_development_dependency "fakefs"
  spec.add_dependency "iso_country_codes"
  spec.add_dependency "iso-639"
end
