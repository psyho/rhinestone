module Rhinestone
  class Server
    takes :http_client, :cache, :later

    def get(path)
      response = cache.get(path)

      unless response
        response = fetch_response(path)
      else
        later.run{ fetch_response(path) }
      end

      return response
    end

    private

    def fetch_response(path)
      response = http_client.get(path)
      cache.set(path, response)
      response
    end
  end
end
