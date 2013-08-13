module ExtremeFeedbackDevice
  class CLI
    class << self
      def instance
        @instance ||= new(ARGV.dup)
      end
    end

    attr_reader :argv

    def initialize(argv)
      @argv = argv
    end

    def mode
      argv[0]
    end

    def settings_yml
      argv[1]
    end

    def settings_ns
      argv[2]
    end

    def usage
      puts <<-EOS
extreme_feedback_device v#{ExtremeFeedbackDevice::VERSION}
------------------------------
USAGE: extreme_feedback_device MODE [SETTINGS_YML] [SETTINGS_NS]
\tMODE:\tcan be run for a single run or loop for an endless loop
\tSETTINGS_YML:\tpath of settings yml file; default: $HOME/.extreme_feedback_device.yml
\tSETTINGS_NS:\tnamespace in settings yml file; default: default
EOS
      -1
    end

    def main
      if argv.length < 1 || argv.length > 3
        usage
      else
        ENV['EFD_YML'] = settings_yml
        ENV['EFD_NS'] = settings_ns

        if mode =~ /^run$/i
          ExtremeFeedbackDevice.run
        elsif mode =~ /^loop$/i
          ExtremeFeedbackDevice.loop
        else
        end
      end
    end
  end
end