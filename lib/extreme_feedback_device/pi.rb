require 'color'
require 'pi_piper'

module ExtremeFeedbackDevice
  class Pi
    attr_reader :leds

    def initialize(num_leds)
      @leds = []
      num_leds.times { @leds << Color::RGB.new }
    end

    def all_on!
      leds.map! { |led| Color::RGB::White }
    end

    def all_off!
      leds.map! { |led| Color::RGB::Black }
    end

    def write!
      PiPiper::Spi.begin do 
        write leds_bin
      end
    end

  private

    def leds_bin
      leds.map { |led| [led.red, led.green, led.blue] }.flatten
    end
  end
end