require "rails_helper"

RSpec.describe Admin::UserTypesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/user_types").to route_to("admin/user_types#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/user_types/new").to route_to("admin/user_types#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/user_types/1").to route_to("admin/user_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/user_types/1/edit").to route_to("admin/user_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/user_types").to route_to("admin/user_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/user_types/1").to route_to("admin/user_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/user_types/1").to route_to("admin/user_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/user_types/1").to route_to("admin/user_types#destroy", :id => "1")
    end

  end
end
