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

    def usage
      puts <<-EOS
extreme_feedback_device v#{ExtremeFeedbackDevice::VERSION}
------------------------------
USAGE: extreme_feedback_device MODE
\tMODE:\tcan be run for a single run or loop for an endless loop
EOS
      -1
    end

    def main
      if argv.length != 1
        usage
      else
        if mode =~ /^run$/i
          ExtremeFeedbackDevice.run
        elsif mode =~ /^loop$/i
          ExtremeFeedbackDevice.infiniti_loop
        else
        end
      end
    end
  end
end