require 'rails_helper'

RSpec.describe "admin/furniture_color_brands/show", type: :view do
  before(:each) do
    @admin_furniture_color_brand = assign(:admin_furniture_color_brand, Admin::FurnitureColorBrand.create!(
      :name => "Name",
      :comment => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
