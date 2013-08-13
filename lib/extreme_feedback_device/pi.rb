require 'color'

require "extreme_feedback_device/spi"

module ExtremeFeedbackDevice
  class Pi
    attr_reader :leds

    def initialize(num_leds, spi_device=nil)
      @leds = []
      num_leds.times { @leds << ::Color::RGB.new }
      @spi_device = spi_device
    end

    def leds_white
      leds.map! { |led| ::Color::RGB::White }
    end

    def leds_white!
      leds_white && write!
    end

    def leds_black
      leds.map! { |led| ::Color::RGB::Black }
    end

    def leds_black!
      leds_black && write!
    end

    def write!
      spi.write_colors(colors)
    end

  private

    def spi
      @spi ||= ExtremeFeedbackDevice::SPI.new(@spi_device)
    end

    def colors
      leds.map { |led| [led.red, led.green, led.blue] }
    end
  end
end