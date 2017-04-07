require 'rails_helper'

RSpec.describe "Admin::UserTypes", type: :request do
  describe "GET /admin_user_types" do
    it "works! (now write some real specs)" do
      get admin_user_types_path
      expect(response).to have_http_status(200)
    end
  end
end
