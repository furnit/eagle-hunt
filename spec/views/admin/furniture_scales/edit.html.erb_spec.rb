require 'rails_helper'

RSpec.describe "admin/furniture_scales/edit", type: :view do
  before(:each) do
    @admin_furniture_scale = assign(:admin_furniture_scale, Admin::FurnitureScale.create!(
      :name => "MyString",
      :comment => "MyString"
    ))
  end

  it "renders the edit admin_furniture_scale form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_scale_path(@admin_furniture_scale), "post" do

      assert_select "input#admin_furniture_scale_name[name=?]", "admin_furniture_scale[name]"

      assert_select "input#admin_furniture_scale_comment[name=?]", "admin_furniture_scale[comment]"
    end
  end
end
