require 'rails_helper'

RSpec.describe "admin/fabric_brands/index", type: :view do
  before(:each) do
    assign(:admin_fabric_brands, [
      Admin::FabricBrand.create!(
        :name => "Name",
        :comment => "MyText"
      ),
      Admin::FabricBrand.create!(
        :name => "Name",
        :comment => "MyText"
      )
    ])
  end

  it "renders a list of admin/fabric_brands" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
