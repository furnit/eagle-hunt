require 'rails_helper'

RSpec.describe "admin/fabric_types/index", type: :view do
  before(:each) do
    assign(:admin_fabric_types, [
      Admin::FabricType.create!(
        :name => "Name",
        :comment => "MyText"
      ),
      Admin::FabricType.create!(
        :name => "Name",
        :comment => "MyText"
      )
    ])
  end

  it "renders a list of admin/fabric_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
