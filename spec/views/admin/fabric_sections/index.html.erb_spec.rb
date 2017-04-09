require 'rails_helper'

RSpec.describe "admin/fabric_sections/index", type: :view do
  before(:each) do
    assign(:admin_fabric_sections, [
      Admin::FabricSection.create!(
        :name => "Name",
        :comment => "Comment",
        :text => "Text"
      ),
      Admin::FabricSection.create!(
        :name => "Name",
        :comment => "Comment",
        :text => "Text"
      )
    ])
  end

  it "renders a list of admin/fabric_sections" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => "Text".to_s, :count => 2
  end
end
