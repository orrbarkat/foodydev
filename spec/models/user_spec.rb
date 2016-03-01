require 'rails_helper'

RSpec.describe User, type: :model do
	before(:each) do
		create(:user)
		@user = build(:user)
	end
  	it "has a valid factory" do
  		expect(@user).to be_valid
  	end
  	
  	it "has a valid facebook factory" do
  	it "has a valid google factory"
  	it "has an email"
  	it "has a phone number between 6-15 digits long"
  	it "the identity provider is facebook google or foodonet"
  	it "uses a valid oauth token"
  	xit "sets uid if id provider is foodonet"
end
