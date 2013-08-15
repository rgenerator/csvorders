# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csvorders/version'

Gem::Specification.new do |spec|
  spec.name          = "csvorders"
  spec.version       = Csvorders::VERSION
  spec.authors       = ["Troy Denkinger"]
  spec.email         = ["troy@rgenerator.com"]
  spec.description   = %q{Generator publishes a specification for formatting orders to be ingested into its commerce platform. This library will help anyone writing to that specification verify the validity of their data.}
  spec.summary       = %q{Validity checker for CSV-based external orders data.}
  spec.homepage      = "https://github.com/rgenerator/csvorders"
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
