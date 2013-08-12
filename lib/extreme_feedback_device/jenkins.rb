require 'json'
require 'net/http'

require "extreme_feedback_device/job"

module ExtremeFeedbackDevice
  class Jenkins < ::Struct.new(:base_url)
    def full_url
      File.join(base_url, 'api', 'json?tree=jobs[name,color,healthReport[score]]')
    end

    def full_uri
      @full_uri ||= URI(full_url)
    end

    def get_json
      request = Net::HTTP::Get.new(full_uri)
      request.basic_auth 'mnowak', '666dc94d24827d7122c307179f467d13'

      response = Net::HTTP.start(full_uri.hostname, full_uri.port) do |http|
        http.request(request)
      end

      if response.is_a?(Net::HTTPSuccess)
        response.body
      else
        nil
      end
    end

    def jobs
      @jobs ||= jobs_from_json(get_json)
    end

  private

    def jobs_from_json(json)
      json_objects = []
      begin
        json_objects = JSON.parse(json)
      rescue JSON::JSONError
      end

      json_objects["jobs"].map { |json_object| ExtremeFeedbackDevice::Job.from_json_object(json_object) }
    end
  end
end