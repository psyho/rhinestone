module Rhinestone
  class Injector
    include Dependor::AutoInject
    look_in_modules Rhinestone

    def cache_backend
      @cache_backend ||= FilesystemCacheBackend.new(".cache")
    end

    def hostname
      "rubygems.org"
    end

    def important_headers
      %w{Content-Type Cache-Control ETag Set-Cookie}
    end
  end
end
