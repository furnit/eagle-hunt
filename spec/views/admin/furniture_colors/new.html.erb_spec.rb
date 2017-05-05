require 'rails_helper'

RSpec.describe "admin/furniture_colors/new", type: :view do
  before(:each) do
    assign(:admin_furniture_color, Admin::FurnitureColor.new(
      :admin_furniture_color_qualities => nil,
      :admin_furniture_color_brand => nil,
      :comment => "MyText",
      :color_value => "MyString",
      :color_details => ""
    ))
  end

  it "renders new admin_furniture_color form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_colors_path, "post" do

      assert_select "input#admin_furniture_color_admin_furniture_color_qualities_id[name=?]", "admin_furniture_color[admin_furniture_color_qualities_id]"

      assert_select "input#admin_furniture_color_admin_furniture_color_brand_id[name=?]", "admin_furniture_color[admin_furniture_color_brand_id]"

      assert_select "textarea#admin_furniture_color_comment[name=?]", "admin_furniture_color[comment]"

      assert_select "input#admin_furniture_color_color_value[name=?]", "admin_furniture_color[color_value]"

      assert_select "input#admin_furniture_color_color_details[name=?]", "admin_furniture_color[color_details]"
    end
  end
end
