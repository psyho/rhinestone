require 'dependor'
require 'dependor/shorty'

require 'goliath'
require 'yaml'

module Rhinestone
  autoload :App,                    'rhinestone/app'
  autoload :Cache,                  'rhinestone/cache'
  autoload :Config,                 'rhinestone/config'
  autoload :FilesystemCacheBackend, 'rhinestone/filesystem_cache_backend'
  autoload :HeaderFilter,           'rhinestone/header_filter'
  autoload :Injector,               'rhinestone/injector'
  autoload :InMemoryCacheBackend,   'rhinestone/in_memory_cache_backend'
  autoload :HttpClient,             'rhinestone/http_client'
  autoload :Later,                  'rhinestone/later'
  autoload :Response,               'rhinestone/response'
  autoload :Server,                 'rhinestone/server'
  autoload :VERSION,                'rhinestone/version'

  def self.server
    Injector.new(config).server
  end

  def self.config
    Rhinestone::Config.new(ARGV).to_h
  end

  def self.run!
    Goliath::Application.app_class = 'Rhinestone::App'
    Goliath::Application.run!
  end
end
