require_relative '../lib/rhinestone'

require 'em-synchrony'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

RSpec.shared_examples_for "cache backend" do
  it "returns nil when key does not exist" do
    cache_backend.get("/some/completely/unknown/file").should be_nil
  end

  it "returns the stored value" do
    cache_backend.set("/foo?bar=baz:hello.json", "some value")

    cache_backend.get("/foo?bar=baz:hello.json").should == "some value"
  end
end
