require 'rails_helper'

RSpec.describe "admin/furniture_color_brands/edit", type: :view do
  before(:each) do
    @admin_furniture_color_brand = assign(:admin_furniture_color_brand, Admin::FurnitureColorBrand.create!(
      :name => "MyString",
      :comment => "MyText"
    ))
  end

  it "renders the edit admin_furniture_color_brand form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_color_brand_path(@admin_furniture_color_brand), "post" do

      assert_select "input#admin_furniture_color_brand_name[name=?]", "admin_furniture_color_brand[name]"

      assert_select "textarea#admin_furniture_color_brand_comment[name=?]", "admin_furniture_color_brand[comment]"
    end
  end
end
