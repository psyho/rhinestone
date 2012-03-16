require_relative '../spec_helper'

describe Rhinestone::InMemoryCacheBackend do
  let(:cache_backend) { Rhinestone::InMemoryCacheBackend.new }

  it_behaves_like "cache backend"
end
