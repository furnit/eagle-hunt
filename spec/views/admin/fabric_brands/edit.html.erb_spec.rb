require 'rails_helper'

RSpec.describe "admin/fabric_brands/edit", type: :view do
  before(:each) do
    @admin_fabric_brand = assign(:admin_fabric_brand, Admin::FabricBrand.create!(
      :name => "MyString",
      :comment => "MyText"
    ))
  end

  it "renders the edit admin_fabric_brand form" do
    render

    assert_select "form[action=?][method=?]", admin_fabric_brand_path(@admin_fabric_brand), "post" do

      assert_select "input#admin_fabric_brand_name[name=?]", "admin_fabric_brand[name]"

      assert_select "textarea#admin_fabric_brand_comment[name=?]", "admin_fabric_brand[comment]"
    end
  end
end
