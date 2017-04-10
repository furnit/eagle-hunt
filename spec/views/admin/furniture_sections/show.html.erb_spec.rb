require 'rails_helper'

RSpec.describe "admin/furniture_sections/show", type: :view do
  before(:each) do
    @admin_furniture_section = assign(:admin_furniture_section, Admin::FurnitureSection.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
