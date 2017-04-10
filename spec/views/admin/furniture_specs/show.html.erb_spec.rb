require 'rails_helper'

RSpec.describe "admin/furniture_specs/show", type: :view do
  before(:each) do
    @admin_furniture_spec = assign(:admin_furniture_spec, Admin::FurnitureSpec.create!(
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
