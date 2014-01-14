require 'json'
require 'net/http'

require "extreme_feedback_device/job"

module ExtremeFeedbackDevice
  class Jenkins < ::Struct.new(:user, :token, :base_url)
    def full_url
      ::File.join(base_url, 'api', 'json?tree=jobs[name,color,healthReport[score]]')
    end

    def full_uri
      URI(full_url)
    end

    def jobs
      json = get_json
      jobs_from_json(json) if json.is_a?(String)
    end

  private

    def jobs_from_json(json)
      json_objects = []
      begin
        json_objects = ::JSON.parse(json)
      rescue ::JSON::JSONError
      end

      json_objects["jobs"].map { |json_object| ExtremeFeedbackDevice::Job.from_json_object(json_object) }
    end

    def get_json
      request = ::Net::HTTP::Get.new(full_uri)
      request.basic_auth(user, token)

      response = nil
      begin
        response = ::Net::HTTP.start(full_uri.hostname, full_uri.port) do |http|
          http.request(request)
        end
      rescue SocketError => e
        response = e
      end

      if response.is_a?(::Net::HTTPSuccess)
        return response.body
      else
        return nil
      end
    end
  end
end