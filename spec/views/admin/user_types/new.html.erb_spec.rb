require 'rails_helper'

RSpec.describe "admin/user_types/new", type: :view do
  before(:each) do
    assign(:admin_user_type, Admin::UserType.new(
      :name => "MyString",
      :comment => "MyText",
      :auth_level => 1
    ))
  end

  it "renders new admin_user_type form" do
    render

    assert_select "form[action=?][method=?]", admin_user_types_path, "post" do

      assert_select "input#admin_user_type_name[name=?]", "admin_user_type[name]"

      assert_select "textarea#admin_user_type_comment[name=?]", "admin_user_type[comment]"

      assert_select "input#admin_user_type_auth_level[name=?]", "admin_user_type[auth_level]"
    end
  end
end
