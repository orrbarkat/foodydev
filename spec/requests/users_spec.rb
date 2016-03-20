require 'rails_helper'

RSpec.describe "Users", type: :request do
	let(:json) { JSON.parse(response.body) }
  describe "GET /users/:id/groups" do
    
    it "is able to get groups" do
      get get_groups_path(1)
      expect(response).to have_http_status(200)
    end

    it "returns an empty array if the user doesnt exist" do
    	get get_groups_path(100)
    	expect(json).to eq([])
    end

    it "returns all groups I'm admin of" do
    	create(:user,:phone_number=>"0123456789")
    	create(:group, :user_id=>User.last.id)
    	create(:group_member, :Group_id => Group.last.id,:phone_number=>"0123456789")
    	get get_groups_path(User.last.id)
    	expect(response.body).to eq([ {group_id: Group.last.id , group_name: Group.last.name, user_id: User.last.id, 
    		members: [ GroupMember.last.attributes]
    		}].to_json)
    end
  end

  describe "GET/ publication for user" do
    it "gets publications" do
      create(:user)
      create(:group, :user_id => User.last.id)
      create(:group_member, :user_id => User.last.id, :phone_number => User.last.phone_number)
      create(:publication, :audience => Group.last.id)
      get get_publications_path(User.last.id)
      expect(json[0][0]['id']).to eq(Publication.last.id)
    end
  end

  it "successfuly creates a user" do
  		 headers = {
  		 	"ACCEPT" => "application/json",
  		 	"CONTENT_TYPE" => "application/json"
  		 }
  		 user = attributes_for(:user)
  		 post "/users.json", { :user => user }.to_json, headers
  		expect(response).to have_http_status(201)
  	end
end