require 'rails_helper'

RSpec.describe User, type: :model do
	before(:each) do
		create(:user)
		@user = build(:user)
	end
  	it "has a valid factory for facebook" do
  		expect(@user).to be_valid
  	end

  	it "has a valid google factory" do
  		user = build(:user,:google)
  		expect(user).to be_valid
  		expect(user.identity_provider).to eq("google")
  	end
  	it "has an email" do
  		@user.identity_provider_email = nil
  		expect(@user).to_not be_valid
  	end

  	it "has a phone number between 9-15 digits long" do
  		@user.phone_number = nil
  		expect(@user).to_not be_valid
  		@user.phone_number = "45678"
  		expect(@user).to_not be_valid
  		@user.phone_number = "45678987654567845678"
  		expect(@user).to_not be_valid
  	end

  	it "the identity provider is facebook google or foodonet" do
  		@user.identity_provider="asdfas"
  		expect(@user).to_not be_valid
  	end
  	it "parses the phone_number correctly" do
  		phone = @user.phone_number
  		expect(@user.normalize_phone).to eq("546684685")
  		@user.phone_number = "abcd0987654567"
  		expect(@user.normalize_phone).to eq("987654567")
  	end
  	
  	it "uses a valid oauth token" 

  	it "sets uid if id provider is foodonet"
end
