class Feedback < ActiveRecord::Base
	belongs_to :active_device

	validates  :active_device_dev_uuid, presence: true
    validates  :reporter_name, {limit:100};
   	validates  :report, presence: true, length: {limit:500};
end
