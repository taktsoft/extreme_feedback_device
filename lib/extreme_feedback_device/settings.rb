require 'settingslogic'

module ExtremeFeedbackDevice
  class Settings < ::Settingslogic
    source(::File.join(::Dir.home, '.extreme_feedback_device.yml'))
    namespace('default')
  end
end