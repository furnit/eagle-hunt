require 'rails_helper'

RSpec.describe "admin/furniture_color_qualities/show", type: :view do
  before(:each) do
    @admin_furniture_color_quality = assign(:admin_furniture_color_quality, Admin::FurnitureColorQuality.create!(
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
