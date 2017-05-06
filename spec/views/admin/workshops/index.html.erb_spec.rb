require 'rails_helper'

RSpec.describe "admin/workshops/index", type: :view do
  before(:each) do
    assign(:admin_workshops, [
      Admin::Workshop.create!(
        :name => "Name",
        :state => nil,
        :address => "MyText",
        :user => nil,
        :phone_number => "Phone Number",
        :comment => "MyText"
      ),
      Admin::Workshop.create!(
        :name => "Name",
        :state => nil,
        :address => "MyText",
        :user => nil,
        :phone_number => "Phone Number",
        :comment => "MyText"
      )
    ])
  end

  it "renders a list of admin/workshops" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
