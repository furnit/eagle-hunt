require 'rails_helper'

RSpec.describe "admin/furniture_sections/edit", type: :view do
  before(:each) do
    @admin_furniture_section = assign(:admin_furniture_section, Admin::FurnitureSection.create!())
  end

  it "renders the edit admin_furniture_section form" do
    render

    assert_select "form[action=?][method=?]", admin_furniture_section_path(@admin_furniture_section), "post" do
    end
  end
end
