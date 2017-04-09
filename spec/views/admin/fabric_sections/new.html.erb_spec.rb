require 'rails_helper'

RSpec.describe "admin/fabric_sections/new", type: :view do
  before(:each) do
    assign(:admin_fabric_section, Admin::FabricSection.new(
      :name => "MyString",
      :comment => "MyString",
      :text => "MyString"
    ))
  end

  it "renders new admin_fabric_section form" do
    render

    assert_select "form[action=?][method=?]", admin_fabric_sections_path, "post" do

      assert_select "input#admin_fabric_section_name[name=?]", "admin_fabric_section[name]"

      assert_select "input#admin_fabric_section_comment[name=?]", "admin_fabric_section[comment]"

      assert_select "input#admin_fabric_section_text[name=?]", "admin_fabric_section[text]"
    end
  end
end
