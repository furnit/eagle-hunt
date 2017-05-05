require 'rails_helper'

RSpec.describe "admin/furniture_color_qualities/edit", type: :view do
  before(:each) do
    @admin_furniture_color_quality = assign(:admin_furniture_color_quality, Admin::FurnitureColorQuality.create!(
      :name => "MyString",
      :comment => "MyText"
    ))
  end

  it "renders the edit admin_furniture_color_quality form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_color_quality_path(@admin_furniture_color_quality), "post" do

      assert_select "input#admin_furniture_color_quality_name[name=?]", "admin_furniture_color_quality[name]"

      assert_select "textarea#admin_furniture_color_quality_comment[name=?]", "admin_furniture_color_quality[comment]"
    end
  end
end
