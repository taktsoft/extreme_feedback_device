require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new

task :default => :spec
task :test => :spec


task :environment do
  require 'extreme_feedback_device'
end

namespace :pi do
  namespace :leds do
    desc "turn all LEDs off / black"
    task off: [:environment] do
      ExtremeFeedbackDevice.pi.leds_black!
    end

    desc "turn all LEDs on / white"
    task on: [:environment] do
      ExtremeFeedbackDevice.pi.leds_white!
    end
  end
end