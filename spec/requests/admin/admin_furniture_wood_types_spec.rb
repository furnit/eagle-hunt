require 'rails_helper'

RSpec.describe "Admin::FurnitureWoodTypes", type: :request do
  describe "GET /admin_furniture_wood_types" do
    it "works! (now write some real specs)" do
      get admin_furniture_wood_types_path
      expect(response).to have_http_status(200)
    end
  end
end
