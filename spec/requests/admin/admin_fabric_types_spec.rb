require 'rails_helper'

RSpec.describe "Admin::FabricTypes", type: :request do
  describe "GET /admin_fabric_types" do
    it "works! (now write some real specs)" do
      get admin_fabric_types_path
      expect(response).to have_http_status(200)
    end
  end
end
