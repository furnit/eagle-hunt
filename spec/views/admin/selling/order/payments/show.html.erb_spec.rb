require 'rails_helper'

RSpec.describe "admin/sellings/show", type: :view do
  before(:each) do
    @admin_selling = assign(:admin_selling, Admin::Selling::Order::Payment.create!(
      :order_order => nil,
      :amount => 2.5,
      :trans_id => "Trans",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/Trans/)
    expect(rendered).to match(/Status/)
  end
end
