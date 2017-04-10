require 'rails_helper'

RSpec.describe "admin/furniture_specs/edit", type: :view do
  before(:each) do
    @admin_furniture_spec = assign(:admin_furniture_spec, Admin::FurnitureSpec.create!(
      :name => "MyString",
      :comment => "MyString"
    ))
  end

  it "renders the edit admin_furniture_spec form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_spec_path(@admin_furniture_spec), "post" do

      assert_select "input#admin_furniture_spec_name[name=?]", "admin_furniture_spec[name]"

      assert_select "input#admin_furniture_spec_comment[name=?]", "admin_furniture_spec[comment]"
    end
  end
end
