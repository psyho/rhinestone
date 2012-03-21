require 'optparse'

module Rhinestone
  class Config

    def initialize(argv)
      @options = extract_options(argv)
    end

    def to_h
      @options
    end

    private

    def extract_options(argv)
      options = {}

      cache_path_idx = argv.index('--cache-path') || argv.index('-C')

      if cache_path_idx
        options[:cache_path] = argv[cache_path_idx + 1]
        argv.slice!(cache_path_idx, 2)
      end

      return options
    end
  end
end
