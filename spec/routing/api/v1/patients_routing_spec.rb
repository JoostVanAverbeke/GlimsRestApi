require "rails_helper"

describe Api::V1::PatientsController do
  describe "routing" do
    context "Valid routes" do
      it "routes to /api/v1/patients" do
        expect(:get => "/api/v1/patients").to be_routable
      end
      it "routes to /api/v1/patients/count" do
        expect(:get => "/api/v1/patients/count").to be_routable
      end
    end

    context "Invalid routes" do

    end
  end
end
