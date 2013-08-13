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
      jobs = jenkins.jobs
      num_leds = settings.pi.num_leds
      map_leds = settings.pi.map_leds

      num_leds.times do |led_idx|
        job_name = map_leds["i_#{led_idx}"]
        if job_name
          job = jobs.find { |job| job.name == job_name }
          if job
            if job.fail?
              pi.leds[led_idx] = Color::RGB::Red
            elsif job.unstable?
              pi.leds[led_idx] = Color::RGB::Yellow
            elsif job.success?
              pi.leds[led_idx] = Color::RGB::Green
            elsif job.inactive?
              pi.leds[led_idx] = Color::RGB::Grey
            elsif job.disabled?
              pi.leds[led_idx] = Color::RGB::Grey
            else # any other state
              pi.leds[led_idx] = Color::RGB::Black
            end
          else # no job with this name in jenkins
            pi.leds[led_idx] = Color::RGB::Black
          end
        else # no job associated with this led_idx
          pi.leds[led_idx] = Color::RGB::Black
        end
      end
      pi.write!
    end

    def infiniti_loop
      while true
        run
        sleep settings.infiniti_loop.sleep
      end
    end
  end
end

require "extreme_feedback_device/cli"
require "extreme_feedback_device/jenkins"
require "extreme_feedback_device/job"
require "extreme_feedback_device/pi"
require "extreme_feedback_device/settings"
require "extreme_feedback_device/spi"