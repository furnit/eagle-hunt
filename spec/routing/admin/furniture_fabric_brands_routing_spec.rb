require "rails_helper"

RSpec.describe Admin::FabricBrandsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/fabric_brands").to route_to("admin/fabric_brands#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/fabric_brands/new").to route_to("admin/fabric_brands#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/fabric_brands/1").to route_to("admin/fabric_brands#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/fabric_brands/1/edit").to route_to("admin/fabric_brands#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/fabric_brands").to route_to("admin/fabric_brands#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/fabric_brands/1").to route_to("admin/fabric_brands#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/fabric_brands/1").to route_to("admin/fabric_brands#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/fabric_brands/1").to route_to("admin/fabric_brands#destroy", :id => "1")
    end

  end
end
