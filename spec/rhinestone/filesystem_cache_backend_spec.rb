require_relative '../spec_helper'

describe Rhinestone::FilesystemCacheBackend do
  after { FileUtils.rm_rf(base_directory) }

  let(:base_directory) { "/tmp/rhinestone/cache" }
  let(:cache_backend) { Rhinestone::FilesystemCacheBackend.new(base_directory) }

  it_behaves_like "cache backend"
end
