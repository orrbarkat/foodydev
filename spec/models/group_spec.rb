require 'rails_helper'

RSpec.describe Group, type: :model do
  it "has a valid factory" do
	expect(create(:group)).to be_valid
	# group = Group.new(create(:group))
	# expect(Group.last.id).to eq(group.id)
  end
  
  it "is invalid without a name" do
  	expect(build(:group, name: nil)).to_not be_valid
  end

  xit "returns all group members " do
  end
end
