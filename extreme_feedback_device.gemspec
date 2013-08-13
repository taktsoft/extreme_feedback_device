# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'extreme_feedback_device/version'

Gem::Specification.new do |spec|
  spec.name          = "extreme_feedback_device"
  spec.version       = ExtremeFeedbackDevice::VERSION
  spec.authors       = ["Michael Nowak"]
  spec.email         = ["nowak@taktsoft.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = "http://www.taktsoft.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "guard-rspec", "~> 2.5"
  spec.add_development_dependency "pry", "~> 0.9"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "rb-fsevent", "~> 0.9"
  spec.add_development_dependency "rb-inotify", "~> 0.9"

  spec.add_dependency "color", "~> 1.4"
  spec.add_dependency "settingslogic", "~> 2.0"
end
