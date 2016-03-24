require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe "Publications", type: :request do
	let(:json) { JSON.parse(response.body) }
  
  describe 'POST /publications' do
    it "successfuly creates a publication" do
  		 headers = {
  		 	"ACCEPT" => "application/json",
  		 	"CONTENT_TYPE" => "application/json"
  		 }
  		 post "/publications.json", { :publication => attributes_for(:publication) }.to_json, headers
  		expect(response).to have_http_status(200)
  	end
  end

  describe 'PUT /publications/:id.json' do
    it "updates a publications successfuly" do
      pub = create(:publication)
      headers = {
        "ACCEPT" => "application/json",
        "CONTENT_TYPE" => "application/json"
       }
      put "/publications/#{pub.id}.json", { :publication => {is_on_air: false} }.to_json, headers
      expect(response).to have_http_status(200)
      expect(Publication.find(pub.id).is_on_air).to be_falsey
    end
  end
end