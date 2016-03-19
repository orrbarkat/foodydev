require 'rails_helper'

RSpec.describe "GroupMembers", type: :request do
	let(:json) { JSON.parse(response.body) }
  describe "GET /group_members" do
    it "works! (now write some real specs)" do
      get group_members_path
      expect(response).to have_http_status(200)
    end
  end
  
  # describe "POST/ group_members" do
  # 	it "creates!" do
 	# 	post group_members_path 		
  # 	end
  # end
  # describe "DELETE /group_members and update admin" do
  # 	it "updates" do
  # 		create(:user,:phone_number=>"0123456789")
  # 		user =  User.find_by_phone_number("0123456789")
  # 		create(:user,:phone_number=>"0909090909")
  #   	create(:group, :user_id=>User.last.id)
  #   	create(:group_member, :Group_id => Group.last.id,:phone_number=>"0123456789", :user_id => user.id, :is_admin => false)
  #   	delete delete_member_path(GroupMember.first.id)
  #   	expect(:json).to eq GroupMember.last
  # 	end
  	
  # end
end
