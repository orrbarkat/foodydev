require 'rails_helper'

RSpec.describe "Groups", type: :request do
	
 let(:json) { JSON.parse(response.body) }

  describe "GET /groups" do
    it "works! (now write some real specs)" do
      get groups_path
      expect(response).to have_http_status(200)
    end
  end

  # describe "POST /group" do
  # 	it"creates new group" do
  # 		create(:user)
  # 		create(:group)
  # 		create(:group_member)
  # 		delete member_path
  # 		expect(:json).to eq Group.last
  # 	end
  # end
end
