require 'rails_helper'

RSpec.describe "admin/fabric_brands/show", type: :view do
  before(:each) do
    @admin_fabric_brand = assign(:admin_fabric_brand, Admin::FabricBrand.create!(
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
