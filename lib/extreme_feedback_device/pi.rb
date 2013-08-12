require 'color'

require "extreme_feedback_device/spi"

module ExtremeFeedbackDevice
  class Pi
    attr_reader :leds

    def initialize(num_leds)
      @leds = []
      num_leds.times { @leds << Color::RGB.new }
    end

    def all_white!
      leds.map! { |led| Color::RGB::White }
    end
    alias :all_white! :all_on!

    def all_black!
      leds.map! { |led| Color::RGB::Black }
    end
    alias :all_black! :all_off!

    def write!
      ExtremeFeedbackDevice::SPI.write(nil, leds_bin)
    end

  private

    def leds_bin
      bin = leds.map { |led| [led.red, led.green, led.blue] }.flatten
      bin.pack('CCC' * leds.length)
    end
  end
end