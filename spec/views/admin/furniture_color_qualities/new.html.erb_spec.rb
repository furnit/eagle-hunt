require 'rails_helper'

RSpec.describe "admin/furniture_color_qualities/new", type: :view do
  before(:each) do
    assign(:admin_furniture_color_quality, Admin::FurnitureColorQuality.new(
      :name => "MyString",
      :comment => "MyText"
    ))
  end

  it "renders new admin_furniture_color_quality form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_color_qualities_path, "post" do

      assert_select "input#admin_furniture_color_quality_name[name=?]", "admin_furniture_color_quality[name]"

      assert_select "textarea#admin_furniture_color_quality_comment[name=?]", "admin_furniture_color_quality[comment]"
    end
  end
end
