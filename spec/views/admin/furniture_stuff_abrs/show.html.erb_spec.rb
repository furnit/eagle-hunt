require 'rails_helper'

RSpec.describe "admin/furniture_stuff_abrs/show", type: :view do
  before(:each) do
    @admin_furniture_stuff_abr = assign(:admin_furniture_stuff_abr, Admin::FurnitureStuffAbr.create!(
      :name => "Name",
      :value => 2.5,
      :comment => "Comment"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/Comment/)
  end
end
