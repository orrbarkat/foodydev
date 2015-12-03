class Feedback < ActiveRecord::Base
	belongs_to :active_device

	validate  :active_device_dev_uuid, presence: true
	validate  :reporter_name, presence: true, length: {limit:100};
    validate  :report, presence: true, length: {limit:500};
end
