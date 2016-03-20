require 'rails_helper'

RSpec.describe Publication, type: :model do
	before(:each) do
		@publication = build(:publication)
	end
  	
    it "has a valid factory" do
  		expect(@publication).to be_valid
  	end

    it "is invalid without dates" do
      @publication.starting_date = nil
      @publication.ending_date = nil
      expect(@publication).to_not be_valid
    end

    it "is invalid without title" do
      @publication.title = nil
      expect(@publication).to_not be_valid
    end

    it "is invalid without address" do
      @publication.address = nil
      expect(@publication).to_not be_valid
    end

  	it "has active dev uuid" do
  		@publication.active_device_dev_uuid= nil
  		expect(@publication).to_not be_valid
  	end
  	
    it "has a default audience" do
      @publication.audience = nil
      @publication.save!
      expect(@publication.audience).to eq(0)
    end

end
