require 'rubygems'

require "extreme_feedback_device/version"

module ExtremeFeedbackDevice
  class << self
    def settings
      @settings ||= ExtremeFeedbackDevice::Settings
    end

    def jenkins
      @jenkins ||= ExtremeFeedbackDevice::Jenkins.new(settings.jenkins.user, settings.jenkins.token, settings.jenkins.url)
    end

    def pi
      @pi ||= ExtremeFeedbackDevice::Pi.new(settings.pi.num_leds)
    end

    def run
      jenkins.jobs.each_with_index do |job, job_idx|
        led_key = settings.pi.map_leds.key(job.name)
        if led_key
          led_idx = led_key[2..-1].to_i
          led = Color::RGB::Green if job.success?
          led = Color::RGB::Red if job.fail?
          pi.leds[led_idx] = led
        else
          led_idx = settings.pi.num_leds - 1 - job_idx
          pi.leds[led_idx] = Color::RGB::Black
        end
      end
      pi.write!
      0
    end

    def loop
      while true
        run
        sleep settings.loop.sleep
      end
      0
    end
  end
end

require "extreme_feedback_device/cli"
require "extreme_feedback_device/jenkins"
require "extreme_feedback_device/job"
require "extreme_feedback_device/pi"
require "extreme_feedback_device/settings"
require "extreme_feedback_device/spi"