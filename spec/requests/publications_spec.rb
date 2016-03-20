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
end