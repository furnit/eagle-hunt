require 'rails_helper'

RSpec.describe "admin/fabric_sections/show", type: :view do
  before(:each) do
    @admin_fabric_section = assign(:admin_fabric_section, Admin::FabricSection.create!(
      :name => "Name",
      :comment => "Comment",
      :text => "Text"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Comment/)
    expect(rendered).to match(/Text/)
  end
end
