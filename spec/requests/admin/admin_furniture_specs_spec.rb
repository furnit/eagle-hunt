require 'rails_helper'

RSpec.describe "Admin::FurnitureSpecs", type: :request do
  describe "GET /admin_furniture_specs" do
    it "works! (now write some real specs)" do
      get admin_furniture_specs_path
      expect(response).to have_http_status(200)
    end
  end
end
