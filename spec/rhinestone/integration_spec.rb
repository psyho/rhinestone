require_relative '../spec_helper'

describe "Rhinestone integration", :vcr do
  it "proxies requests to rubygems.org" do
    response = nil

    EM.synchrony do
      response = Rhinestone.server.get("/")
      EM.stop
    end

    response.status.should == 200
    response.headers["Content-Type"].should_not be_nil
    response.body.should include("RubyGems.org")
  end

  it "caches the requests" do
    server = Rhinestone.server
    response_one = response_two = nil

    EM.synchrony do
      response_one = server.get("/")
      response_two = server.get("/")
      EM.stop
    end

    response_one.should == response_two
  end
end
