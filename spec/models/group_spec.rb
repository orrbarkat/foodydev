require 'rails_helper'

RSpec.describe Group, type: :model do
  it "has a valid factory" do
    puts build(:group)
  	expect(build(:group)).to be_valid
  	# group = Group.new(create(:group))
  	# expect(Group.last.id).to eq(group.id)
  end
  
  it "is invalid without a name" do
  	expect(build(:group, name: nil)).to_not be_valid
  end

  it "has a valid owner" do
    expect(build(:group).user.instance_of? User).to be true
  end

end
