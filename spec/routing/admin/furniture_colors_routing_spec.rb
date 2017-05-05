require "rails_helper"

RSpec.describe Admin::FurnitureColorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/furniture_colors").to route_to("admin/furniture_colors#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/furniture_colors/new").to route_to("admin/furniture_colors#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/furniture_colors/1").to route_to("admin/furniture_colors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/furniture_colors/1/edit").to route_to("admin/furniture_colors#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/furniture_colors").to route_to("admin/furniture_colors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/furniture_colors/1").to route_to("admin/furniture_colors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/furniture_colors/1").to route_to("admin/furniture_colors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/furniture_colors/1").to route_to("admin/furniture_colors#destroy", :id => "1")
    end

  end
end
