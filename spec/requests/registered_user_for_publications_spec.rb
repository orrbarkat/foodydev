require 'spec_helper'

describe "RegisteredUserForPublications" do
  describe "GET /registered_user_for_publications" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get registered_user_for_publications_path
      response.status.should be(200)
    end
  end
end
