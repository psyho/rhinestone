require_relative '../spec_helper'

describe Rhinestone::HttpClient, :vcr do
  let(:http_client) { Rhinestone::HttpClient.new("rubygems.org") }

  it "returns a Rhinestone::Response" do
    response = nil

    EM.synchrony do
      response = http_client.get("/")
      EM.stop
    end

    response.status.should == 200
    response.headers['Content-Type'].should_not be_nil
    response.body.should include('RubyGems.org')
  end
end
