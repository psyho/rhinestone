module Rhinestone
  class Injector
    include Dependor::AutoInject
    look_in_modules Rhinestone

    def cache_backend
      @cache_backend ||= InMemoryCacheBackend.new
    end
  end
end
