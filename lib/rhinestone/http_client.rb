require 'em-synchrony/em-http'

module Rhinestone
  class HttpClient
    takes :hostname

    def get(path)
      response = EM::HttpRequest.new("http://#{hostname}#{path}").get
      headers = response.response_header
      return Rhinestone::Response.new(headers.status,
                                      headers,
                                      response.response)
    end
  end
end
