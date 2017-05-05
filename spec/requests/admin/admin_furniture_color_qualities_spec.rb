require 'rails_helper'

RSpec.describe "Admin::FurnitureColorQualities", type: :request do
  describe "GET /admin_furniture_color_qualities" do
    it "works! (now write some real specs)" do
      get admin_furniture_color_qualities_path
      expect(response).to have_http_status(200)
    end
  end
end
