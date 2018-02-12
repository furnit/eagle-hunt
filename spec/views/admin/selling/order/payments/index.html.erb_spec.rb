require 'rails_helper'

RSpec.describe "admin/sellings/index", type: :view do
  before(:each) do
    assign(:admin_selling_order_payments, [
      Admin::Selling::Order::Payment.create!(
        :order_order => nil,
        :amount => 2.5,
        :trans_id => "Trans",
        :status => "Status"
      ),
      Admin::Selling::Order::Payment.create!(
        :order_order => nil,
        :amount => 2.5,
        :trans_id => "Trans",
        :status => "Status"
      )
    ])
  end

  it "renders a list of admin/sellings" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "Trans".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
