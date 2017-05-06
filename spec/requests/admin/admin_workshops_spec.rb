require 'rails_helper'

RSpec.describe "Admin::Workshops", type: :request do
  describe "GET /admin_workshops" do
    it "works! (now write some real specs)" do
      get admin_workshops_path
      expect(response).to have_http_status(200)
    end
  end
end
