require 'rails_helper'

RSpec.describe "admin/furniture_scales/new", type: :view do
  before(:each) do
    assign(:admin_furniture_scale, Admin::FurnitureScale.new(
      :name => "MyString",
      :comment => "MyString"
    ))
  end

  it "renders new admin_furniture_scale form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_scales_path, "post" do

      assert_select "input#admin_furniture_scale_name[name=?]", "admin_furniture_scale[name]"

      assert_select "input#admin_furniture_scale_comment[name=?]", "admin_furniture_scale[comment]"
    end
  end
end
