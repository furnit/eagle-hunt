require 'rails_helper'

RSpec.describe "admin/fabric_types/new", type: :view do
  before(:each) do
    assign(:admin_fabric_type, Admin::FabricType.new(
      :name => "MyString",
      :comment => "MyText"
    ))
  end

  it "renders new admin_fabric_type form" do
    render

    assert_select "form[action=?][method=?]", admin_fabric_types_path, "post" do

      assert_select "input#admin_fabric_type_name[name=?]", "admin_fabric_type[name]"

      assert_select "textarea#admin_fabric_type_comment[name=?]", "admin_fabric_type[comment]"
    end
  end
end
