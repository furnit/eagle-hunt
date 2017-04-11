require 'rails_helper'

RSpec.describe "Admin::FurnitureScales", type: :request do
  describe "GET /admin_furniture_scales" do
    it "works! (now write some real specs)" do
      get admin_furniture_scales_path
      expect(response).to have_http_status(200)
    end
  end
end
