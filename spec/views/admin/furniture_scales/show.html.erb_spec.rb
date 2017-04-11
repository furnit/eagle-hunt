require 'rails_helper'

RSpec.describe "admin/furniture_scales/show", type: :view do
  before(:each) do
    @admin_furniture_scale = assign(:admin_furniture_scale, Admin::FurnitureScale.create!(
      :name => "Name",
      :comment => "Comment"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Comment/)
  end
end
