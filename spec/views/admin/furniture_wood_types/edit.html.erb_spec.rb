require 'rails_helper'

RSpec.describe "admin/furniture_wood_types/edit", type: :view do
  before(:each) do
    @admin_furniture_wood_type = assign(:admin_furniture_wood_type, Admin::FurnitureWoodType.create!(
      :name => "MyString",
      :comment => "MyText"
    ))
  end

  it "renders the edit admin_furniture_wood_type form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_wood_type_path(@admin_furniture_wood_type), "post" do

      assert_select "input#admin_furniture_wood_type_name[name=?]", "admin_furniture_wood_type[name]"

      assert_select "textarea#admin_furniture_wood_type_comment[name=?]", "admin_furniture_wood_type[comment]"
    end
  end
end
