require 'rails_helper'
require ENV["push_path"]

RSpec.describe Push do 
	it "creates an instance" do
		publication = create(:publication)
		push = Push.new(publication)
		expect(push).to_not eq(nil)
	end

	xit "pushes to android devices" do
		publication = create(:publication)
		create(:active_device)
		current_report = create(:publication_report)
		push = Push.new(publication, current_report )
		expect(push.user_report).to_not eq(nil)
		push.gcm.report
	end
	

end