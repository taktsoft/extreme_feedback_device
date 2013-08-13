require 'getoptlong'
require 'pidfile'

module ExtremeFeedbackDevice
  class CLI
    DEFAULT_MODE = 'run'
    DEFAULT_NAMESPACE = 'default'
    DEFAULT_PID = '~/.extreme_feedback_device.pid'
    DEFAULT_SETTINGS = '~/.extreme_feedback_device.yml'

    class << self
      def instance
        @instance ||= new
      end
    end

    attr_reader :opts, :pid_file

    def initialize
      @opts = ::GetoptLong.new(
        [ '--help', '-h', ::GetoptLong::NO_ARGUMENT ],
        [ '--mode', '-m', ::GetoptLong::REQUIRED_ARGUMENT ],
        [ '--namespace', '-n', ::GetoptLong::REQUIRED_ARGUMENT ],
        [ '--pid', '-p', ::GetoptLong::REQUIRED_ARGUMENT ],
        [ '--settings', '-s', ::GetoptLong::REQUIRED_ARGUMENT ],
        [ '--version', '-v', ::GetoptLong::NO_ARGUMENT ]
      )
    end

    def mode
      @mode || DEFAULT_MODE
    end

    def namespace
      @namespace || DEFAULT_NAMESPACE
    end

    def pid
      @pid || DEFAULT_PID # File.expand_path(@pid || DEFAULT_PID)
    end

    def settings
      @settings || DEFAULT_SETTINGS # File.expand_path(@settings || DEFAULT_SETTINGS)
    end

    def main
      parse_opts!

      if argv.length > 0
        puts_help
        exit -1
      else
        @pid_file = PidFile.new(piddir: File.expand_path(pid_dir), pidfile: pid_name)

        ExtremeFeedbackDevice::Settings.source(File.expand_path(settings))
        ExtremeFeedbackDevice::Settings.namespace(namespace)
        ExtremeFeedbackDevice::Settings.reload!

        if mode =~ /^run$/i
          ExtremeFeedbackDevice.run
          exit 0
        elsif mode =~ /^loop$/i
          ExtremeFeedbackDevice.infiniti_loop
          exit 0
        else
          puts_help
          exit -1
        end
      end
    end

  private

    def argv
      ARGV
    end

    def pid_dir
      File.dirname(pid)
    end

    def pid_name
      File.basename(pid)
    end

    def parse_opts!
      begin
        opts.each do |opt, arg|
          case opt
            when '--help'
              puts_help
              exit 0
            when '--mode'
              @mode = arg
            when '--namespace'
              @namespace = arg
            when '--pid'
              @pid = arg
            when '--settings'
              @settings = arg
            when '--version'
              puts_version
              exit 0
          end
        end        
      rescue ::GetoptLong::Error => error
        puts # linebreak
        puts_help
        exit -1
      end
    end

    def puts_help
      puts <<-EOS
extreme_feedback_device [OPTION] ...

-h, --help:
\tshow help.

-m, --mode [#{DEFAULT_MODE}]:
\tset mode 'run' for a single run or 'loop' for infiniti loop.

-n, --namespace [#{DEFAULT_NAMESPACE}]:
\tsettings namespace.

-p, --pid [#{DEFAULT_PID}]:
\tpid file.

-s, --settings [#{DEFAULT_SETTINGS}]:
\tsettings file.

-v, --version:
\tshow version.

EOS
    end

    def version
      puts <<-EOS
extreme_feedback_device v#{ExtremeFeedbackDevice::VERSION}

EOS
    end
  end
end