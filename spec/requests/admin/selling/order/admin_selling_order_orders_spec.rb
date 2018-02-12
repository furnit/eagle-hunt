require 'rails_helper'

RSpec.describe "Admin::Selling::Order::Orders", type: :request do
  describe "GET /admin_selling_order_orders" do
    it "works! (now write some real specs)" do
      get admin_selling_order_orders_path
      expect(response).to have_http_status(200)
    end
  end
end
