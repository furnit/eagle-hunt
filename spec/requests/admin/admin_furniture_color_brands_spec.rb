require 'rails_helper'

RSpec.describe "Admin::FurnitureColorBrands", type: :request do
  describe "GET /admin_furniture_color_brands" do
    it "works! (now write some real specs)" do
      get admin_furniture_color_brands_path
      expect(response).to have_http_status(200)
    end
  end
end
