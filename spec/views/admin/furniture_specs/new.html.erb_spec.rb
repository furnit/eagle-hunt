require 'rails_helper'

RSpec.describe "admin/furniture_specs/new", type: :view do
  before(:each) do
    assign(:admin_furniture_spec, Admin::FurnitureSpec.new(
      :name => "MyString",
      :comment => "MyString"
    ))
  end

  it "renders new admin_furniture_spec form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_specs_path, "post" do

      assert_select "input#admin_furniture_spec_name[name=?]", "admin_furniture_spec[name]"

      assert_select "input#admin_furniture_spec_comment[name=?]", "admin_furniture_spec[comment]"
    end
  end
end
