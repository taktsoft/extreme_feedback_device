module ExtremeFeedbackDevice
  class CLI
    class << self
      def instance
        @instance ||= self.new(ARGV.dup)
      end
    end

    attr_reader :argv

    def initialize(argv)
      @argv = argv
    end

    def base_url
      argv.last
    end

    def usage
      puts <<-EOS
extreme_feedback_device v#{ExtremeFeedbackDevice::VERSION}
------------------------------
USAGE: extreme_feedback_device BASE_URL

EOS
    end

    def main
      if argv.length != 1
        usage
        return -1
      else
        jobs = ExtremeFeedbackDevice.jenkins_jobs(base_url)
        jobs.each do |job|
          puts job.to_hash.inspect
        end
        return 0
      end
    end
  end
end