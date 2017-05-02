require 'rails_helper'

RSpec.describe "admin/fabrics/show", type: :view do
  before(:each) do
    @admin_fabric = assign(:admin_fabric, Admin::Fabric.create!(
      :admin_fabric_type => nil,
      :admin_fabric_brand => nil,
      :comment => "MyText",
      :images => "",
      :images_detail => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
