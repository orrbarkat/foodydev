class Feedback < ActiveRecord::Base
	belongs_to :active_device

	validates  :active_device_dev_uuid, presence: true
    validates  :reporter_name, length: {maximum:100}
   	validates  :report, presence: true, length: {maximum:500}
end
