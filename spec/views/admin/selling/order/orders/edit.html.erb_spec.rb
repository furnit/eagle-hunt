require 'rails_helper'

RSpec.describe "admin/sellings/edit", type: :view do
  before(:each) do
    @admin_selling = assign(:admin_selling, Admin::Selling::Order::Order.create!())
  end

  it "renders the edit admin_selling form" do
    render

    assert_select "form[action=?][method=?]", admin_selling_path(@admin_selling), "post" do
    end
  end
end
