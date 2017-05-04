require 'rails_helper'

RSpec.describe "admin/fabric_types/show", type: :view do
  before(:each) do
    @admin_fabric_type = assign(:admin_fabric_type, Admin::FabricType.create!(
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