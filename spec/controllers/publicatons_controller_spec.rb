require 'spec_helper'

describe "PublicationsController" do
  context "#index" do
    before do
      @publication = double(Publication, title: "Some title", address: "Herzliya")
      allow(Publication).to recieve(:all).and_return([@publication, @publication])
    end

    it "should return all publication" do
      get :index, format: :json
      expect(JSON.parse(response.body)).to include([{title: @publication.title, address: @publication.address}])
    end
  end
end