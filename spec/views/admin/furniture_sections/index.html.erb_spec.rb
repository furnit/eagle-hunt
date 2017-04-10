require 'rails_helper'

RSpec.describe "admin/furniture_sections/index", type: :view do
  before(:each) do
    assign(:admin_furniture_sections, [
      Admin::FurnitureSection.create!(),
      Admin::FurnitureSection.create!()
    ])
  end

  it "renders a list of admin/furniture_sections" do
    render
  end
end
