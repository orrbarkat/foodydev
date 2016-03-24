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
       #{ :publication => attributes_for(:publication) }.to_json
  		 post "/publications.json", {:publication=>{:address=>"ישעיהו 30-46,תל אביב יפו", :photo_url=>"", :ending_date=>1458891983, :title=>"test create job", :active_device_dev_uuid=>"a0912a2f2c1a31fc", :longitude=>34.7797807, :starting_date=>1458809183, :latitude=>32.0933729, :is_on_air=>true, :subtitle=>"", :type_of_collecting=>2, :contact_info=>"0547524401"}}.to_json, headers
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