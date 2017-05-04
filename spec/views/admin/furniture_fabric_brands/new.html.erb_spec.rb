require 'rails_helper'

RSpec.describe "admin/fabric_brands/new", type: :view do
  before(:each) do
    assign(:admin_fabric_brand, Admin::FabricBrand.new(
      :name => "MyString",
      :comment => "MyText"
    ))
  end

  it "renders new admin_fabric_brand form" do
    render

    assert_select "form[action=?][method=?]", admin_fabric_brands_path, "post" do

      assert_select "input#admin_fabric_brand_name[name=?]", "admin_fabric_brand[name]"

      assert_select "textarea#admin_fabric_brand_comment[name=?]", "admin_fabric_brand[comment]"
    end
  end
end
