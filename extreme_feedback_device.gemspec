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
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rb-fsevent"
  spec.add_development_dependency "rb-inotify"

  spec.add_dependency "color"
end
