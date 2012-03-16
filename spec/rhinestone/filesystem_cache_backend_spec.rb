require_relative '../spec_helper'

describe Rhinestone::FilesystemCacheBackend do
  let(:base_directory) { "/tmp/rhinestone/cache" }

  after { FileUtils.rm_rf(base_directory) }

  let(:cache_backend) { Rhinestone::FilesystemCacheBackend.new(base_directory) }

  it "returns nil when key does not exist" do
    cache_backend.get("/some/completely/unknown/file").should be_nil
  end

  it "returns the stored value" do
    cache_backend.set("/foo?bar=baz:hello.json", "some value")

    cache_backend.get("/foo?bar=baz:hello.json").should == "some value"
  end
end
