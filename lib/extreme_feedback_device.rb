require "extreme_feedback_device/boot"
require "extreme_feedback_device/version"

module ExtremeFeedbackDevice
  class << self
    def run(user, token, base_url, spi_device=nil)
      num_leds = 25
      time_sleep = 5
      #
      jenkins = ExtremeFeedbackDevice::Jenkins.new(user, token, base_url)
      pi = ExtremeFeedbackDevice::Pi.new(num_leds)
      #
      jenkins.jobs.each_with_index do |job, job_idx|
        led_idx = num_leds - job_idx
        led = job.success? ? Color::RGB::Green : Color::RGB::Red
        pi.leds[led_idx] = led
      end
      pi.write!
      0
    end
  end
end

require "extreme_feedback_device/cli"
require "extreme_feedback_device/jenkins"
require "extreme_feedback_device/job"
require "extreme_feedback_device/pi"
require "extreme_feedback_device/spi"