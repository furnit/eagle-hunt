require 'rails_helper'

RSpec.describe "admin/furniture_stuff_abrs/new", type: :view do
  before(:each) do
    assign(:admin_furniture_stuff_abr, Admin::FurnitureStuffAbr.new(
      :name => "MyString",
      :value => 1.5,
      :comment => "MyString"
    ))
  end

  it "renders new admin_furniture_stuff_abr form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_stuff_abrs_path, "post" do

      assert_select "input#admin_furniture_stuff_abr_name[name=?]", "admin_furniture_stuff_abr[name]"

      assert_select "input#admin_furniture_stuff_abr_value[name=?]", "admin_furniture_stuff_abr[value]"

      assert_select "input#admin_furniture_stuff_abr_comment[name=?]", "admin_furniture_stuff_abr[comment]"
    end
  end
end
