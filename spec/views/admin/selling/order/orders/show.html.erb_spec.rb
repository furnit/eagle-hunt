require 'rails_helper'

RSpec.describe "admin/sellings/show", type: :view do
  before(:each) do
    @admin_selling = assign(:admin_selling, Admin::Selling::Order::Order.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
