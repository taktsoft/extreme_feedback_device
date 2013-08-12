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

    def jenkins_user
      argv[0]
    end

    def jenkins_token
      argv[1]
    end

    def jenkins_url
      argv[2]
    end

    def spi_device
      argv[3]
    end

    def usage
      puts <<-EOS
extreme_feedback_device v#{ExtremeFeedbackDevice::VERSION}
------------------------------
USAGE: extreme_feedback_device JENKINS_USER JENKINS_TOKEN JENKINS_URL [SPI_DEVICE]
\tJENKINS_USER:\tuser for http basic auth on jenkins api
\tJENKINS_TOKEN:\ttoken for http basic auth on jenkins api
\tJENKINS_URL:\tbase url of jenkins
\tSPI_DEVICE:\tspi device name; default: /dev/spidev0.0
EOS
      -1
    end

    def run
      ExtremeFeedbackDevice.run(jenkins_user, jenkins_token, jenkins_url, spi_device)
    end

    def main
      if argv.length < 3 || argv.length > 4
        usage
      else
        run
      end
    end
  end
end