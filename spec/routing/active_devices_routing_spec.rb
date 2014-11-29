require "spec_helper"

describe ActiveDevicesController do
  describe "routing" do

    it "routes to #index" do
      get("/active_devices").should route_to("active_devices#index")
    end

    it "routes to #new" do
      get("/active_devices/new").should route_to("active_devices#new")
    end

    it "routes to #show" do
      get("/active_devices/1").should route_to("active_devices#show", :id => "1")
    end

    it "routes to #edit" do
      get("/active_devices/1/edit").should route_to("active_devices#edit", :id => "1")
    end

    it "routes to #create" do
      post("/active_devices").should route_to("active_devices#create")
    end

    it "routes to #update" do
      put("/active_devices/1").should route_to("active_devices#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/active_devices/1").should route_to("active_devices#destroy", :id => "1")
    end

  end
end
