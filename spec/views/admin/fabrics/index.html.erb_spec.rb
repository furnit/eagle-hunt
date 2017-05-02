require 'rails_helper'

RSpec.describe "admin/fabrics/index", type: :view do
  before(:each) do
    assign(:admin_fabrics, [
      Admin::Fabric.create!(
        :admin_fabric_type => nil,
        :admin_fabric_brand => nil,
        :comment => "MyText",
        :images => "",
        :images_detail => ""
      ),
      Admin::Fabric.create!(
        :admin_fabric_type => nil,
        :admin_fabric_brand => nil,
        :comment => "MyText",
        :images => "",
        :images_detail => ""
      )
    ])
  end

  it "renders a list of admin/fabrics" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
