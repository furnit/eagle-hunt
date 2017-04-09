require 'rails_helper'

RSpec.describe "Admin::FabricSections", type: :request do
  describe "GET /admin_fabric_sections" do
    it "works! (now write some real specs)" do
      get admin_fabric_sections_path
      expect(response).to have_http_status(200)
    end
  end
end
