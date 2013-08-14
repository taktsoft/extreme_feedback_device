# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'extreme_feedback_device/version'

Gem::Specification.new do |spec|
  spec.name          = "extreme_feedback_device"
  spec.version       = ExtremeFeedbackDevice::VERSION
  spec.authors       = ["Michael Nowak"]
  spec.email         = ["nowak@taktsoft.com"]
  spec.summary       = %q{Sets LEDs of an Extreme Feedback Device to a Status of a Job in Jenkins}
  spec.summary       = "Fetches Jobs from a Jenkins CI via the REST JSON API and sets LEDs of an Extreme Feedback Device to the status of the corresponding Job."
  spec.description   = "#{spec.summary} Build and designed for running on a Raspberry Pi with Debian 7."
  spec.homepage      = "https://github.com/taktsoft/#{spec.name}"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "color", "~> 1.4"
  spec.add_dependency "daemons", "~> 1.1"
  spec.add_dependency "settingslogic", "~> 2.0"
  spec.add_dependency "pidfile", "~> 0.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "guard-rspec", "~> 2.5"
  spec.add_development_dependency "pry", "~> 0.9"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "rb-fsevent", "~> 0.9"
  spec.add_development_dependency "rb-inotify", "~> 0.9"
end
