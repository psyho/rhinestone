require_relative '../spec_helper'

describe "Rhinestone integration" do
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
end
