require "rails_helper"

RSpec.describe Admin::FurnitureColorBrandsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/furniture_color_brands").to route_to("admin/furniture_color_brands#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/furniture_color_brands/new").to route_to("admin/furniture_color_brands#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/furniture_color_brands/1").to route_to("admin/furniture_color_brands#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/furniture_color_brands/1/edit").to route_to("admin/furniture_color_brands#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/furniture_color_brands").to route_to("admin/furniture_color_brands#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/furniture_color_brands/1").to route_to("admin/furniture_color_brands#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/furniture_color_brands/1").to route_to("admin/furniture_color_brands#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/furniture_color_brands/1").to route_to("admin/furniture_color_brands#destroy", :id => "1")
    end

  end
end
