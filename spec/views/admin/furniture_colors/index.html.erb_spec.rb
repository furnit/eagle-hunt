require 'rails_helper'

RSpec.describe "admin/furniture_colors/index", type: :view do
  before(:each) do
    assign(:admin_furniture_colors, [
      Admin::FurnitureColor.create!(
        :admin_furniture_color_qualities => nil,
        :admin_furniture_color_brand => nil,
        :comment => "MyText",
        :color_value => "Color Value",
        :color_details => ""
      ),
      Admin::FurnitureColor.create!(
        :admin_furniture_color_qualities => nil,
        :admin_furniture_color_brand => nil,
        :comment => "MyText",
        :color_value => "Color Value",
        :color_details => ""
      )
    ])
  end

  it "renders a list of admin/furniture_colors" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Color Value".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
