require "rails_helper"

RSpec.describe Admin::Selling::Order::PaymentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/sellings").to route_to("admin/sellings#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/sellings/new").to route_to("admin/sellings#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/sellings/1").to route_to("admin/sellings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/sellings/1/edit").to route_to("admin/sellings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/sellings").to route_to("admin/sellings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/sellings/1").to route_to("admin/sellings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/sellings/1").to route_to("admin/sellings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/sellings/1").to route_to("admin/sellings#destroy", :id => "1")
    end

  end
end
