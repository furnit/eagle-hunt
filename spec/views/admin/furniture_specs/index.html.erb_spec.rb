require 'rails_helper'

RSpec.describe "admin/furniture_specs/index", type: :view do
  before(:each) do
    assign(:admin_furniture_specs, [
      Admin::FurnitureSpec.create!(
        :name => "Name",
        :comment => "Comment"
      ),
      Admin::FurnitureSpec.create!(
        :name => "Name",
        :comment => "Comment"
      )
    ])
  end

  it "renders a list of admin/furniture_specs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
  end
end
