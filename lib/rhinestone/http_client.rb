require 'em-synchrony/em-http'

module Rhinestone
  class HttpClient
    takes :hostname, :header_filter

    def get(path)
      response = EM::HttpRequest.new("http://#{hostname}#{path}").get(:redirects => 5)
      headers = response.response_header
      return Rhinestone::Response.new(headers.status,
                                      header_filter.filter(headers),
                                      response.response)
    end
  end
end
