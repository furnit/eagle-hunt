require 'rails_helper'

RSpec.describe "admin/furniture_stuff_abrs/edit", type: :view do
  before(:each) do
    @admin_furniture_stuff_abr = assign(:admin_furniture_stuff_abr, Admin::FurnitureStuffAbr.create!(
      :name => "MyString",
      :value => 1.5,
      :comment => "MyString"
    ))
  end

  it "renders the edit admin_furniture_stuff_abr form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_stuff_abr_path(@admin_furniture_stuff_abr), "post" do

      assert_select "input#admin_furniture_stuff_abr_name[name=?]", "admin_furniture_stuff_abr[name]"

      assert_select "input#admin_furniture_stuff_abr_value[name=?]", "admin_furniture_stuff_abr[value]"

      assert_select "input#admin_furniture_stuff_abr_comment[name=?]", "admin_furniture_stuff_abr[comment]"
    end
  end
end
