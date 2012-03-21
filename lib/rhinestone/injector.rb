module Rhinestone
  class Injector
    include Dependor::AutoInject
    look_in_modules Rhinestone

    def initialize(opts = {})
      @cache_path = opts.fetch(:cache_path, '/tmp/rhinestone/cache')
    end

    def cache_backend
      @cache_backend ||= FilesystemCacheBackend.new(@cache_path)
    end

    def hostname
      "rubygems.org"
    end

    def important_headers
      %w{Content-Type Cache-Control ETag Set-Cookie}
    end
  end
end
