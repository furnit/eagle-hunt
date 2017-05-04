require "rails_helper"

RSpec.describe Admin::FabricsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/fabrics").to route_to("admin/fabrics#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/fabrics/new").to route_to("admin/fabrics#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/fabrics/1").to route_to("admin/fabrics#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/fabrics/1/edit").to route_to("admin/fabrics#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/fabrics").to route_to("admin/fabrics#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/fabrics/1").to route_to("admin/fabrics#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/fabrics/1").to route_to("admin/fabrics#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/fabrics/1").to route_to("admin/fabrics#destroy", :id => "1")
    end

  end
end
