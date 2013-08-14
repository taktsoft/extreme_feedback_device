require 'settingslogic'

module ExtremeFeedbackDevice
  class Settings < ::Settingslogic
    def self.config_file
      if ExtremeFeedbackDevice.environment == "test"
        ::File.join('spec', 'extreme_feedback_device.yml')
      else
        ::File.join(::Dir.home, '.extreme_feedback_device.yml')
      end
    end

    if File.exists?(config_file)
      source(config_file)
    end

    namespace('default')
  end
end
