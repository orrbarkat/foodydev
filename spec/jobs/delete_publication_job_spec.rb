require 'rails_helper'

RSpec.describe DeletePublicationJob, type: :job do
  before(:each) do
    Resque::Failure.clear
  end

  it 'enqueues in resque' do
  	pub = create(:publication)
  	size = Resque.size("default")
  	DeletePublicationJob.perform_later(pub.id)
  	expect(Resque.size("default")).to eq(size+1)
  end

  it "deletes the publication" do
  	pub = create(:publication, is_on_air: false, ending_date: 0)
  	DeletePublicationJob.perform_now(pub.id)
  	expect(Publication.exists?(pub.id)).to be_falsey
  end

end
