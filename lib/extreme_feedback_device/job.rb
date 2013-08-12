module ExtremeFeedbackDevice
  class Job < ::Struct.new(:name, :color, :health)
    # http://buildsystem.bonn.taktsoft.com/api/schema
    COLOR_RED = /\Ared/
    COLOR_YELLOW = /\Ayellow/
    COLOR_BLUE = /\Ablue/
    COLOR_GREY = /\Agrey/
    COLOR_DISABLED = /\Adisabled/
    COLOR_ABORTED = /\Aaborted/
    COLOR_NOTBUILT = /\Anotbuilt/

    class << self
      def from_json_object(attributes)
        health_report = attributes['healthReport']
        attributes['score'] = health_report.first.nil? ? nil : health_report.first['score']
        self.new(attributes['name'], attributes['color'], attributes['score'])
      end
    end

    def to_hash
      {name: name, color: color, health: health}
    end

    def fail?
      color && color =~ COLOR_RED
    end

    def unstable?
      color && color =~ COLOR_YELLOW
    end

    def success?
      color && color =~ COLOR_BLUE
    end

    def inactive?
      color && color =~ COLOR_GREY
    end

    def disabled?
      color && color =~ COLOR_DISABLED
    end

    def aborted?
      color && color =~ COLOR_ABORTED
    end

    def not_built?
      color && color =~ COLOR_NOTBUILT
    end
  end
end