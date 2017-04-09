require 'rails_helper'

RSpec.describe "admin/fabric_sections/edit", type: :view do
  before(:each) do
    @admin_fabric_section = assign(:admin_fabric_section, Admin::FabricSection.create!(
      :name => "MyString",
      :comment => "MyString",
      :text => "MyString"
    ))
  end

  it "renders the edit admin_fabric_section form" do
    render

    assert_select "form[action=?][method=?]", admin_fabric_section_path(@admin_fabric_section), "post" do

      assert_select "input#admin_fabric_section_name[name=?]", "admin_fabric_section[name]"

      assert_select "input#admin_fabric_section_comment[name=?]", "admin_fabric_section[comment]"

      assert_select "input#admin_fabric_section_text[name=?]", "admin_fabric_section[text]"
    end
  end
end
