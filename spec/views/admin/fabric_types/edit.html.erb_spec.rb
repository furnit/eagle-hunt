require 'rails_helper'

RSpec.describe "admin/fabric_types/edit", type: :view do
  before(:each) do
    @admin_fabric_type = assign(:admin_fabric_type, Admin::FabricType.create!(
      :name => "MyString",
      :comment => "MyText"
    ))
  end

  it "renders the edit admin_fabric_type form" do
    render

    assert_select "form[action=?][method=?]", admin_fabric_type_path(@admin_fabric_type), "post" do

      assert_select "input#admin_fabric_type_name[name=?]", "admin_fabric_type[name]"

      assert_select "textarea#admin_fabric_type_comment[name=?]", "admin_fabric_type[comment]"
    end
  end
end
