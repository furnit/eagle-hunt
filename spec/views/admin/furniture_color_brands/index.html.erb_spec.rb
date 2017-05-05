require 'rails_helper'

RSpec.describe "admin/furniture_color_brands/index", type: :view do
  before(:each) do
    assign(:admin_furniture_color_brands, [
      Admin::FurnitureColorBrand.create!(
        :name => "Name",
        :comment => "MyText"
      ),
      Admin::FurnitureColorBrand.create!(
        :name => "Name",
        :comment => "MyText"
      )
    ])
  end

  it "renders a list of admin/furniture_color_brands" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
