require 'rails_helper'

RSpec.describe "admin/fabrics/edit", type: :view do
  before(:each) do
    @admin_fabric = assign(:admin_fabric, Admin::Fabric.create!(
      :admin_fabric_type => nil,
      :admin_fabric_brand => nil,
      :comment => "MyText",
      :images => "",
      :images_detail => ""
    ))
  end

  it "renders the edit admin_fabric form" do
    render

    assert_select "form[action=?][method=?]", admin_fabric_path(@admin_fabric), "post" do

      assert_select "input#admin_fabric_admin_fabric_type_id[name=?]", "admin_fabric[admin_fabric_type_id]"

      assert_select "input#admin_fabric_admin_fabric_brand_id[name=?]", "admin_fabric[admin_fabric_brand_id]"

      assert_select "textarea#admin_fabric_comment[name=?]", "admin_fabric[comment]"

      assert_select "input#admin_fabric_images[name=?]", "admin_fabric[images]"

      assert_select "input#admin_fabric_images_detail[name=?]", "admin_fabric[images_detail]"
    end
  end
end
