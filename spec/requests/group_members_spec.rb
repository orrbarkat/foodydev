require 'rails_helper'

RSpec.describe "GroupMembers", type: :request do
  describe "GET /group_members" do
    it "works! (now write some real specs)" do
      get group_members_path
      expect(response).to have_http_status(200)
    end
  end
end
