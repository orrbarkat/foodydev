require 'rails_helper'

RSpec.describe "GroupMembers", type: :request do
	let(:json) { JSON.parse(response.body) }
  describe "GET /group_members" do
    it "works! (now write some real specs)" do
      get group_members_path
      expect(response).to have_http_status(200)
    end
  end
  
  describe "DELETE /group_members and update admin" do
  	it "updates when deleting admin" do
  		create(:user)
      create(:group)
      create(:group_member, :is_admin => false)
      create(:user)
      create(:group_member, :is_admin => true)
      count = GroupMember.count
      delete delete_member_path(GroupMember.last.id)
      expect(GroupMember.last.is_admin).to eq true 
      expect(GroupMember.count).to eq (count - 1)
 
  	end
    
    it "keeps admin when deleting non_admin member" do
        create(:user)
        create(:group)
        create(:group_member, :is_admin => true)
        create(:user)
        create(:group_member, :is_admin => false)
        count = GroupMember.count
        delete delete_member_path(GroupMember.last.id)
        expect(GroupMember.last.is_admin).to eq true 
        expect(GroupMember.count).to eq (count - 1)     
    end
    	
  end
end
