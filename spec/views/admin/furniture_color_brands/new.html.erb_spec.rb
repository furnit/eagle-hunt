require 'rails_helper'

RSpec.describe "admin/furniture_color_brands/new", type: :view do
  before(:each) do
    assign(:admin_furniture_color_brand, Admin::FurnitureColorBrand.new(
      :name => "MyString",
      :comment => "MyText"
    ))
  end

  it "renders new admin_furniture_color_brand form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_color_brands_path, "post" do

      assert_select "input#admin_furniture_color_brand_name[name=?]", "admin_furniture_color_brand[name]"

      assert_select "textarea#admin_furniture_color_brand_comment[name=?]", "admin_furniture_color_brand[comment]"
    end
  end
end
