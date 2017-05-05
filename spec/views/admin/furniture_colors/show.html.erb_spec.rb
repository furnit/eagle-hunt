require 'rails_helper'

RSpec.describe "admin/furniture_colors/show", type: :view do
  before(:each) do
    @admin_furniture_color = assign(:admin_furniture_color, Admin::FurnitureColor.create!(
      :admin_furniture_color_qualities => nil,
      :admin_furniture_color_brand => nil,
      :comment => "MyText",
      :color_value => "Color Value",
      :color_details => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Color Value/)
    expect(rendered).to match(//)
  end
end
