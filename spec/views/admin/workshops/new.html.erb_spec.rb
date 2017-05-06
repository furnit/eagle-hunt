require 'rails_helper'

RSpec.describe "admin/workshops/new", type: :view do
  before(:each) do
    assign(:admin_workshop, Admin::Workshop.new(
      :name => "MyString",
      :state => nil,
      :address => "MyText",
      :user => nil,
      :phone_number => "MyString",
      :comment => "MyText"
    ))
  end

  it "renders new admin_workshop form" do
    render

    assert_select "form[action=?][method=?]", admin_workshops_path, "post" do

      assert_select "input#admin_workshop_name[name=?]", "admin_workshop[name]"

      assert_select "input#admin_workshop_state_id[name=?]", "admin_workshop[state_id]"

      assert_select "textarea#admin_workshop_address[name=?]", "admin_workshop[address]"

      assert_select "input#admin_workshop_user_id[name=?]", "admin_workshop[user_id]"

      assert_select "input#admin_workshop_phone_number[name=?]", "admin_workshop[phone_number]"

      assert_select "textarea#admin_workshop_comment[name=?]", "admin_workshop[comment]"
    end
  end
end
