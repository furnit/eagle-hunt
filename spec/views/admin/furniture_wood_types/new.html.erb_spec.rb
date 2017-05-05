require 'rails_helper'

RSpec.describe "admin/furniture_wood_types/new", type: :view do
  before(:each) do
    assign(:admin_furniture_wood_type, Admin::FurnitureWoodType.new(
      :name => "MyString",
      :comment => "MyText"
    ))
  end

  it "renders new admin_furniture_wood_type form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_wood_types_path, "post" do

      assert_select "input#admin_furniture_wood_type_name[name=?]", "admin_furniture_wood_type[name]"

      assert_select "textarea#admin_furniture_wood_type_comment[name=?]", "admin_furniture_wood_type[comment]"
    end
  end
end
