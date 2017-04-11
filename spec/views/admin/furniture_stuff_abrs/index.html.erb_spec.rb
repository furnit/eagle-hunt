require 'rails_helper'

RSpec.describe "admin/furniture_stuff_abrs/index", type: :view do
  before(:each) do
    assign(:admin_furniture_stuff_abrs, [
      Admin::FurnitureStuffAbr.create!(
        :name => "Name",
        :value => 2.5,
        :comment => "Comment"
      ),
      Admin::FurnitureStuffAbr.create!(
        :name => "Name",
        :value => 2.5,
        :comment => "Comment"
      )
    ])
  end

  it "renders a list of admin/furniture_stuff_abrs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
  end
end
