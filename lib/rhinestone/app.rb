module Rhinestone
  class App < Goliath::API
    def initialize
      @server =  Rhinestone.server
    end

    def response(env)
      response = @server.get("#{env['REQUEST_PATH']}?#{env['QUERY_STRING']}")

      [response.status, response.headers, response.body]
    end
  end
end
