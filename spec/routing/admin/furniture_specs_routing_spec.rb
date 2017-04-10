require "rails_helper"

RSpec.describe Admin::FurnitureSpecsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/furniture_specs").to route_to("admin/furniture_specs#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/furniture_specs/new").to route_to("admin/furniture_specs#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/furniture_specs/1").to route_to("admin/furniture_specs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/furniture_specs/1/edit").to route_to("admin/furniture_specs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/furniture_specs").to route_to("admin/furniture_specs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/furniture_specs/1").to route_to("admin/furniture_specs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/furniture_specs/1").to route_to("admin/furniture_specs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/furniture_specs/1").to route_to("admin/furniture_specs#destroy", :id => "1")
    end

  end
end
