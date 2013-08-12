require "extreme_feedback_device/boot"
require "extreme_feedback_device/version"

module ExtremeFeedbackDevice
  class << self
    def jenkins_jobs(base_url)
      jenkins = ExtremeFeedbackDevice::Jenkins.new(base_url)
      jenkins.jobs
    end
  end
end

require "extreme_feedback_device/cli"
require "extreme_feedback_device/jenkins"
require "extreme_feedback_device/job"
require "extreme_feedback_device/pi"
require "extreme_feedback_device/spi"