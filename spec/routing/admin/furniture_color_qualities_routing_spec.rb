require "rails_helper"

RSpec.describe Admin::FurnitureColorQualitiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/furniture_color_qualities").to route_to("admin/furniture_color_qualities#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/furniture_color_qualities/new").to route_to("admin/furniture_color_qualities#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/furniture_color_qualities/1").to route_to("admin/furniture_color_qualities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/furniture_color_qualities/1/edit").to route_to("admin/furniture_color_qualities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/furniture_color_qualities").to route_to("admin/furniture_color_qualities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/furniture_color_qualities/1").to route_to("admin/furniture_color_qualities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/furniture_color_qualities/1").to route_to("admin/furniture_color_qualities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/furniture_color_qualities/1").to route_to("admin/furniture_color_qualities#destroy", :id => "1")
    end

  end
end
