require 'rails_helper'

RSpec.describe "admin/sellings/index", type: :view do
  before(:each) do
    assign(:admin_selling_order_orders, [
      Admin::Selling::Order::Order.create!(),
      Admin::Selling::Order::Order.create!()
    ])
  end

  it "renders a list of admin/sellings" do
    render
  end
end
