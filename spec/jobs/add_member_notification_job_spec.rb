require 'rails_helper'

RSpec.describe AddMemberNotificationJob, type: :job do
  before(:each) do
    Resque::Failure.clear
  end
  it 'enqueues in resque' do
  	group = create(:group)
  	create(:group_member, phone_number: create(:user).phone_number)
  	size = Resque.size("default")
  	AddMemberNotificationJob.perform_later(group.id)
  	expect(Resque.size("default")).to eq(size+1)
  end

  it "performs now" do
  	group = create(:group)
  	create(:group_member, phone_number: create(:user).phone_number)
  	AddMemberNotificationJob.perform_now(group.id)
  	expect(Resque::Failure.all).to be_nil
  end
end
