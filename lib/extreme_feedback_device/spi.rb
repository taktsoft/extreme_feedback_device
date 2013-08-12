module ExtremeFeedbackDevice
  class SPI
    DEFAULT_DEVICE = '/dev/spidev0.0'

    class << self
      def write(device, data)
        new(device).write(data)
      end
    end

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
  end
end