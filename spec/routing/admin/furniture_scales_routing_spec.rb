require "rails_helper"

RSpec.describe Admin::FurnitureScalesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/furniture_scales").to route_to("admin/furniture_scales#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/furniture_scales/new").to route_to("admin/furniture_scales#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/furniture_scales/1").to route_to("admin/furniture_scales#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/furniture_scales/1/edit").to route_to("admin/furniture_scales#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/furniture_scales").to route_to("admin/furniture_scales#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/furniture_scales/1").to route_to("admin/furniture_scales#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/furniture_scales/1").to route_to("admin/furniture_scales#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/furniture_scales/1").to route_to("admin/furniture_scales#destroy", :id => "1")
    end

  end
end
