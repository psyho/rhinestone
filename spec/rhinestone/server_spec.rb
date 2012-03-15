require_relative '../spec_helper'

describe Rhinestone::Server do
  let(:http_client) { stub(:http_client) }
  let(:cache) { stub(:cache) }
  let(:server) { Rhinestone::Server.new(http_client, cache, later) }
  let(:response) { stub(:response) }
  let(:later) { FakeLater.new }

  class FakeLater
    attr_reader :block

    def run(&block)
      @block = block
    end
  end

  context "when the data is not in cache" do
    before do
      cache.stub(:get).and_return(nil)
      http_client.should_receive(:get).with("/hello/world").and_return(response)
      cache.stub(:set)
    end

    it "returns the data from http_client" do
      proxy_response = server.get("/hello/world")

      proxy_response.should == response
    end

    it "saves the data in cache" do
      cache.should_receive(:set).with("/hello/world", response)

      server.get("/hello/world")
    end
  end

  context "when the data is in cache" do
    before do
      cache.should_receive(:get).with("/hello/world").and_return(response)
    end

    it "returns the data from cache to the client" do
      proxy_response = server.get("/hello/world")

      proxy_response.should == response
    end

    it "gets the data from http_client and saves it in cache in the background" do
      server.get("/hello/world")

      http_response = stub(:http_response)
      http_client.should_receive(:get).with("/hello/world").and_return(http_response)
      cache.should_receive(:set).with("/hello/world", http_response)

      later.block.should_not be_nil
      later.block.call
    end
  end
end
