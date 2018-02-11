require 'rails_helper'

RSpec.describe "admin/sellings/edit", type: :view do
  before(:each) do
    @admin_selling = assign(:admin_selling, Admin::Selling::Payment::Payment.create!(
      :order/order => nil,
      :amount => 1.5,
      :trans_id => "MyString",
      :status => "MyString"
    ))
  end

  it "renders the edit admin_selling form" do
    render

    assert_select "form[action=?][method=?]", admin_selling_path(@admin_selling), "post" do

      assert_select "input#admin_selling_order/order_id[name=?]", "admin_selling[order/order_id]"

      assert_select "input#admin_selling_amount[name=?]", "admin_selling[amount]"

      assert_select "input#admin_selling_trans_id[name=?]", "admin_selling[trans_id]"

      assert_select "input#admin_selling_status[name=?]", "admin_selling[status]"
    end
  end
end
