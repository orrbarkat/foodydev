require "spec_helper"

describe RegisteredUserForPublicationsController do
  describe "routing" do

    it "routes to #index" do
      get("/registered_user_for_publications").should route_to("registered_user_for_publications#index")
    end

    it "routes to #new" do
      get("/registered_user_for_publications/new").should route_to("registered_user_for_publications#new")
    end

    it "routes to #show" do
      get("/registered_user_for_publications/1").should route_to("registered_user_for_publications#show", :id => "1")
    end

    it "routes to #edit" do
      get("/registered_user_for_publications/1/edit").should route_to("registered_user_for_publications#edit", :id => "1")
    end

    it "routes to #create" do
      post("/registered_user_for_publications").should route_to("registered_user_for_publications#create")
    end

    it "routes to #update" do
      put("/registered_user_for_publications/1").should route_to("registered_user_for_publications#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/registered_user_for_publications/1").should route_to("registered_user_for_publications#destroy", :id => "1")
    end

  end
end
