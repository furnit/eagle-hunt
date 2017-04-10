require "rails_helper"

RSpec.describe Admin::FurnitureSectionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/furniture_sections").to route_to("admin/furniture_sections#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/furniture_sections/new").to route_to("admin/furniture_sections#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/furniture_sections/1").to route_to("admin/furniture_sections#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/furniture_sections/1/edit").to route_to("admin/furniture_sections#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/furniture_sections").to route_to("admin/furniture_sections#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/furniture_sections/1").to route_to("admin/furniture_sections#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/furniture_sections/1").to route_to("admin/furniture_sections#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/furniture_sections/1").to route_to("admin/furniture_sections#destroy", :id => "1")
    end

  end
end
