module ExtremeFeedbackDevice
  class SPI
    DEFAULT_DEVICE = '/dev/spidev0.0'

    attr_reader :device

    def initialize(device=nil)
      @device = device || DEFAULT_DEVICE
    end

    def write(data)
      File.open(device, 'wb') do |spi|
        spi.write(data)
        spi.flush
      end
    end

    def write_colors(colors)
      write(colors_to_data(colors))
    end

  private

    def colors_to_data(colors)
      colors.flatten.pack('CCC' * colors.length)
    end
  end
end