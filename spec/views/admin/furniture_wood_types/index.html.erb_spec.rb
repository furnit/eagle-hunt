require 'rails_helper'

RSpec.describe "admin/furniture_wood_types/index", type: :view do
  before(:each) do
    assign(:admin_furniture_wood_types, [
      Admin::FurnitureWoodType.create!(
        :name => "Name",
        :comment => "MyText"
      ),
      Admin::FurnitureWoodType.create!(
        :name => "Name",
        :comment => "MyText"
      )
    ])
  end

  it "renders a list of admin/furniture_wood_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
