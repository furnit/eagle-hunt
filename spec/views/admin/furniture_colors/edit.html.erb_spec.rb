require 'rails_helper'

RSpec.describe "admin/furniture_colors/edit", type: :view do
  before(:each) do
    @admin_furniture_color = assign(:admin_furniture_color, Admin::FurnitureColor.create!(
      :admin_furniture_color_qualities => nil,
      :admin_furniture_color_brand => nil,
      :comment => "MyText",
      :color_value => "MyString",
      :color_details => ""
    ))
  end

  it "renders the edit admin_furniture_color form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_color_path(@admin_furniture_color), "post" do

      assert_select "input#admin_furniture_color_admin_furniture_color_qualities_id[name=?]", "admin_furniture_color[admin_furniture_color_qualities_id]"

      assert_select "input#admin_furniture_color_admin_furniture_color_brand_id[name=?]", "admin_furniture_color[admin_furniture_color_brand_id]"

      assert_select "textarea#admin_furniture_color_comment[name=?]", "admin_furniture_color[comment]"

      assert_select "input#admin_furniture_color_color_value[name=?]", "admin_furniture_color[color_value]"

      assert_select "input#admin_furniture_color_color_details[name=?]", "admin_furniture_color[color_details]"
    end
  end
end
