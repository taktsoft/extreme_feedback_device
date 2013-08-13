require 'settingslogic'

module ExtremeFeedbackDevice
  class Settings < ::Settingslogic
    source ENV["EFD_YML"] || File.join(Dir.home, '.extreme_feedback_device.yml')
    namespace ENV["EFD_NS"] || 'default'
  end
end