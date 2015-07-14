require "rails_helper"

describe Api::V1::LoginController do
  describe "Routing" do
    context "Valid routes" do
      it "routes to /api/v1/login" do
        expect(:post => "/api/v1/login").to be_routable
      end
    end

    context "Invalid routes" do

    end
  end
end