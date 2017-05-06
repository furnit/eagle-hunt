require "rails_helper"

RSpec.describe Admin::WorkshopsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/workshops").to route_to("admin/workshops#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/workshops/new").to route_to("admin/workshops#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/workshops/1").to route_to("admin/workshops#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/workshops/1/edit").to route_to("admin/workshops#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/workshops").to route_to("admin/workshops#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/workshops/1").to route_to("admin/workshops#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/workshops/1").to route_to("admin/workshops#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/workshops/1").to route_to("admin/workshops#destroy", :id => "1")
    end

  end
end
