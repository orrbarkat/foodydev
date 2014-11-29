require "spec_helper"

describe PublicationReportsController do
  describe "routing" do

    it "routes to #index" do
      get("/publication_reports").should route_to("publication_reports#index")
    end

    it "routes to #new" do
      get("/publication_reports/new").should route_to("publication_reports#new")
    end

    it "routes to #show" do
      get("/publication_reports/1").should route_to("publication_reports#show", :id => "1")
    end

    it "routes to #edit" do
      get("/publication_reports/1/edit").should route_to("publication_reports#edit", :id => "1")
    end

    it "routes to #create" do
      post("/publication_reports").should route_to("publication_reports#create")
    end

    it "routes to #update" do
      put("/publication_reports/1").should route_to("publication_reports#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/publication_reports/1").should route_to("publication_reports#destroy", :id => "1")
    end

  end
end
