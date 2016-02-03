require 'rails_helper'

RSpec.describe GroupMember, type: :model do
  	before(:each) do
		create(:group)
		@member = build(:group_member)
	end
  	
  	it "has a valid factory" do
  		expect(@member).to be_valid
  	end
  
  	it "is invalid without a name" do
  		expect(build(:group_member, name: nil)).to_not be_valid
  	end

  	it "is part of a valid group" do
    	expect(@member.group.instance_of? Group).to be true
  	end
  
  	it "finds a user with matching phone" do
  		r_number = "0" 
  		9.times do
  			r_number += rand(0..10).to_s
  		end
  		create(:user , phone_number: r_number)
  		member = build(:group_member, phone_number: r_number)
  		member.validate
  		expect(member.user_id).to eq(User.last.id)
  	end

  	it "sets user_id to 0 if no phone has been found " do
  		create(:user)
  		member = build(:group_member, phone_number: "0000000000")
  		member.validate
  		expect(member.user_id).to eq(0)
  	end
end
