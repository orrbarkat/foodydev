require 'rails_helper'

RSpec.describe "Users", type: :request do
	let(:json) { JSON.parse(response.body) }
  describe "GET /users/:id/groups" do
    
    it "is able to get groups" do
      get get_groups_path(1)
      puts response.body
      expect(response).to have_http_status(200)
    end

    it "returns an empty array if the user doesnt exist" do
    	get get_groups_path(100)
    	expect(json).to eq([])
    end

    # it "returns all groups I'm admin of" do
    	# create(:user)
    	# create(:group, :user_id=>User.last.id)
    	# create(:group_member, :Group_id => Group.last.id)
    	# get get_groups_path(User.last.id)
    	# expect(json).to eq([{Group.last.id, Group.last.name, User.last.id, [GroupMember.last]}])
    # end
  end

  it "successfuly creates a user" do
  		 headers = {
  		 	"ACCEPT" => "application/json",
  		 	"CONTENT_TYPE" => "application/json"
  		 }
  		 user = build(:user).attributes.except(:id,:created_at,:updated_at)
  		 post "/users", { :user => user }.to_json, headers
  		expect(response).to have_http_status(200)
  	end
end
