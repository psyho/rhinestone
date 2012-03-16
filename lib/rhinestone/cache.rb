module Rhinestone
  class Cache
    takes :cache_backend

    class KeyNotFound < RuntimeError; end

    def set(url, response)
      cache_backend.set("status:#{url}", response.status.to_s)
      cache_backend.set("headers:#{url}", response.headers.to_yaml)
      cache_backend.set("body:#{url}", response.body)
    end

    def get(url)
      status = get!("status:#{url}").to_i
      headers = YAML.load(get!("headers:#{url}"))
      body = get!("body:#{url}")
      return Rhinestone::Response.new(status, headers, body)
    rescue KeyNotFound
      return nil
    end

    private

    def get!(key)
      cache_backend.get(key) or raise KeyNotFound
    end

  end
end
