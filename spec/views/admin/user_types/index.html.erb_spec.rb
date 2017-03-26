require 'rails_helper'

RSpec.describe "admin/user_types/index", type: :view do
  before(:each) do
    assign(:admin_user_types, [
      Admin::UserType.create!(
        :name => "Name",
        :comment => "MyText",
        :auth_level => 2
      ),
      Admin::UserType.create!(
        :name => "Name",
        :comment => "MyText",
        :auth_level => 2
      )
    ])
  end

  it "renders a list of admin/user_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
