require_relative '../spec_helper'

describe Rhinestone::Cache do

  class InMemoryCacheBackend
    attr_reader :data

    def initialize
      @data = {}
    end

    def set(key, value)
      data[key] = value
    end

    def get(key)
      data[key]
    end
  end


  let(:cache_backend) { InMemoryCacheBackend.new }
  let(:cache) { Rhinestone::Cache.new(cache_backend) }

  let(:response) {
    Rhinestone::Response.new(200, {'Content-Type' => 'application/json'}, 'some body')
  }

  it "stores response serialized as 3 separate key-value pairs" do
    cache.set('/gems.json', response)

    cache_backend.data.keys.size.should == 3
  end

  it "deserializes response from the key-value pairs" do
    cache.set('/gems.json', response)
    cache.get('/gems.json').should == response
  end

  it "returns nil if any of the 3 pairs was not present in cache_backend" do
    cache.get('/gems.json').should be_nil
  end
end
