require 'rails_helper'

RSpec.describe CreatePublicationJob, type: :job do
  it 'enqueues in resque' do
  	pub = create(:publication)
  	CreatePublicationJob.perform_now(pub.id)
  	size = Resque.size("default")
  	CreatePublicationJob.perform_later(pub.id)
  	expect(Resque.size("default")).to eq(size+1)
  end
end
