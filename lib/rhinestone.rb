require 'dependor'
require 'dependor/shorty'

module Rhinestone
  autoload :Cache, 'rhinestone/cache'
  autoload :Injector, 'rhinestone/injector'
  autoload :HttpClient, 'rhinestone/http_client'
  autoload :Later, 'rhinestone/later'
  autoload :Response, 'rhinestone/response'
  autoload :Server, 'rhinestone/server'
  autoload :VERSION, 'rhinestone/version'

  def self.server
    Injector.new.server
  end
end
