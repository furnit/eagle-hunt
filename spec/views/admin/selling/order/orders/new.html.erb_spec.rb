require 'rails_helper'

RSpec.describe "admin/sellings/new", type: :view do
  before(:each) do
    assign(:admin_selling, Admin::Selling::Order::Order.new())
  end

  it "renders new admin_selling form" do
    render

    assert_select "form[action=?][method=?]", admin_selling_order_orders_path, "post" do
    end
  end
end
