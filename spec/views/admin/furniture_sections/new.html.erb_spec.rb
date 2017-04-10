require 'rails_helper'

RSpec.describe "admin/furniture_sections/new", type: :view do
  before(:each) do
    assign(:admin_furniture_section, Admin::FurnitureSection.new())
  end

  it "renders new admin_furniture_section form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_sections_path, "post" do
    end
  end
end
