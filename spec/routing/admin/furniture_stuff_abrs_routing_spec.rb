require "rails_helper"

RSpec.describe Admin::FurnitureStuffAbrsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/furniture_stuff_abrs").to route_to("admin/furniture_stuff_abrs#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/furniture_stuff_abrs/new").to route_to("admin/furniture_stuff_abrs#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/furniture_stuff_abrs/1").to route_to("admin/furniture_stuff_abrs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/furniture_stuff_abrs/1/edit").to route_to("admin/furniture_stuff_abrs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/furniture_stuff_abrs").to route_to("admin/furniture_stuff_abrs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/furniture_stuff_abrs/1").to route_to("admin/furniture_stuff_abrs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/furniture_stuff_abrs/1").to route_to("admin/furniture_stuff_abrs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/furniture_stuff_abrs/1").to route_to("admin/furniture_stuff_abrs#destroy", :id => "1")
    end

  end
end
