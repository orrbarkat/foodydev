require 'rails_helper'

RSpec.describe CreatePublicationJob, type: :job do
  it 'enqueues in resque' do
  	pub = Publication.last ? Publication.last : create(:publication)[0]
  	CreatePublicationJob.perform_now(pub.id)
  end
end
