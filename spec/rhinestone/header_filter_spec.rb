require_relative '../spec_helper'

describe Rhinestone::HeaderFilter do
  let(:important_headers) {
    ['Content-Type', 'ETag']
  }

  let(:headers) {
    FakeHeaders.new('Status' => 200, 'Content-Type' => 'application/json')
  }

  let(:filter) { Rhinestone::HeaderFilter.new(important_headers) }

  it "returns only the headers that are important and exist" do
    filter.filter(headers).should == {'Content-Type' => 'application/json'}
  end

  # limit the hash interface to only one method
  # because em-http returns headers uppercased with "indifferent access" via []
  class FakeHeaders
    def initialize(data)
      @data = data
    end

    def [](name)
      return @data[name]
    end
  end
end
