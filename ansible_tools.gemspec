# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ansible_tools/version'

Gem::Specification.new do |spec|
  spec.name          = "ansible_tools"
  spec.version       = AnsibleTools::VERSION
  spec.authors       = ["volanja"]
  spec.email         = ["volaaanja@gmail.com"]
  spec.description   = %q{Ansible Tools e.g. Create directory by BestPractice}
  spec.summary       = %q{Ansible Tools e.g. Create directory by BestPractice}
  spec.homepage      = "https://github.com/volanja"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "thor", "~> 0.18.1"
end
