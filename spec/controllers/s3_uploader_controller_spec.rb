require 'rails_helper'

RSpec.describe S3UploaderController, type: :controller do

  describe "GET #s3_access_token" do
    it "returns http success" do
      get :s3_access_token
      expect(response).to have_http_status(:success)
    end
  end

end
