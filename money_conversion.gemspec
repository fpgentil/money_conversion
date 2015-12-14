# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'money_conversion/version'

Gem::Specification.new do |spec|
  spec.name          = "money_conversion"
  spec.version       = MoneyConversion::VERSION
  spec.authors       = ["Felipe Gentil"]
  spec.email         = ["cdigentil@gmail.com"]

  spec.summary       = %q{An awesome currency converter!}
  spec.description   = %q{A currency converter with arithmetic support}
  spec.homepage      = "https://github.com/fpgentil/money_conversion"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.9"
end
