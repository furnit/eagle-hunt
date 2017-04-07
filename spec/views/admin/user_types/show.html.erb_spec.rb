require 'rails_helper'

RSpec.describe "admin/user_types/show", type: :view do
  before(:each) do
    @admin_user_type = assign(:admin_user_type, Admin::UserType.create!(
      :name => "Name",
      :comment => "MyText",
      :auth_level => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
  end
end
