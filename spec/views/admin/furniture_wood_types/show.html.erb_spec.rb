require 'rails_helper'

RSpec.describe "admin/furniture_wood_types/show", type: :view do
  before(:each) do
    @admin_furniture_wood_type = assign(:admin_furniture_wood_type, Admin::FurnitureWoodType.create!(
      :name => "Name",
      :comment => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
