require 'rails_helper'

RSpec.describe "admin/workshops/show", type: :view do
  before(:each) do
    @admin_workshop = assign(:admin_workshop, Admin::Workshop.create!(
      :name => "Name",
      :state => nil,
      :address => "MyText",
      :user => nil,
      :phone_number => "Phone Number",
      :comment => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/MyText/)
  end
end
