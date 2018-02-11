require 'rails_helper'

RSpec.describe "Admin::Selling::Payment::Payments", type: :request do
  describe "GET /admin_selling_payment_payments" do
    it "works! (now write some real specs)" do
      get admin_selling_payment_payments_path
      expect(response).to have_http_status(200)
    end
  end
end
