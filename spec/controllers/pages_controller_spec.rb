require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #connect_as" do
    it "returns http success" do
      get :connect_as
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #sign_in" do
    it "returns http success" do
      get :sign_in
      expect(response).to have_http_status(:success)
    end
  end

end
